<template>
  <div>
    <BookInfo :info="info"></BookInfo>
    <CommentList :comments="comments"></CommentList>
    <div class="comment" v-if="showAdd">
      <textarea
        v-model="comment" 
        class="textarea" 
        :maxlength="100"
        placeholder="请输入图书短评"
      ></textarea>
      <div class="location">
        地理位置：
        <switch @change="getGeo" :checked="location" color="#EA5A49" ></switch>
        <span class="right text-primary">{{location}}</span>
      </div>
      <div class="phone">
        手机型号：
        <switch @change="getPhone" :checked="phone" color="#EA5A49" ></switch>
        <span class="right text-primary">{{phone}}</span>
      </div>
      <button class="btn" @click="addComment">评论</button>
    </div>
    <div v-else class="text-footer">
      <span v-if="!userInfo.openId">未登录</span>
      <span v-else>您已经评论过了</span>
    </div>
    <button class="btn" open-type="share">转发给好友</button>
  </div>
</template>

<script>
import { get, post, showModal } from '@/utils'
import BookInfo from '@/components/BookInfo'
import CommentList from '@/components/CommentList'

export default {
  data () {
    return {
      bookid: '',
      userInfo: {},
      comments: [],
      info: {},
      comment: '',
      location: '',
      phone: ''
    }
  },
  computed: {
    showAdd () {
      if (!this.userInfo.openId) {
        return false
      }
      // 评论列表查到 有自己的openid
      if (this.comments.filter((v) => v.openid === this.userInfo.openId).length) {
        return false
      }
      return true
    }
  },
  onShareAppMessage () {
    return {
      title: '自定义转发标题',
      path: '/page/Detail/main'
    }
  },
  mounted () {
    // mpvue.com常见问题
    this.bookid = this.$root.$mp.query.id
    this.getDetail()
    this.getComments()
    const userInfo = wx.getStorageSync('userInfo')
    if (userInfo) {
      this.userInfo = userInfo
    }
  },
  methods: {
    async getDetail () {
      const info = await get('/weapp/bookdetail', {id: this.bookid})
      wx.setNavigationBarTitle({
        title: info.title
      })
      this.info = info
    },
    getPhone (e) {
      if (e.target.value) {
        try {
          const res = wx.getSystemInfoSync()
          this.phone = res.model
        } catch (e) {
          // Do something when catch error
        }
      } else {
        this.phone = ''
      }
    },
    getGeo (e) {
      const ak = 'oAyw5jCiGVST5vMN1kPqYaGYEGj2PMxW'
      let url = 'http://api.map.baidu.com/geocoder/v2/'
      if (e.target.value) {
        let _this = this
        wx.getLocation({
          type: 'wgs84',
          success (res) {
            const latitude = res.latitude
            const longitude = res.longitude
            wx.request({
              url,
              data: {
                location: `${latitude},${longitude}`,
                output: 'json',
                ak
              },
              success (res) {
                const data = res.data
                if (data.status === 0) {
                  _this.location = data.result.addressComponent.city
                } else {
                  _this.location = '未知地点'
                  console.log('获取位置失败')
                }
              }
            })
          }
        })
      } else {
        this.location = ''
      }
    },
    async addComment () {
      if (!this.comment) {
        return
      }
      const data = {
        openid: this.userInfo.openId,
        bookid: this.bookid,
        comment: this.comment,
        location: this.location,
        phone: this.phone
      }
      try {
        await post('/weapp/addcomment', data)
        this.comment = ''
        this.getComments()
      } catch (e) {
        showModal('失败', e.msg)
      }
    },
    async getComments () {
      const comments = await get('/weapp/commentlist', {bookid: this.bookid})
      this.comments = comments.list || []
    }
  },
  components: {
    BookInfo,
    CommentList
  }
}
</script>

<style lang="scss" scoped>
.comment {
  margin-top: 10px;
  .textarea {
    width: 100%;
    height: 200rpx;
    background: #eee;
    padding: 10px;
  }
  .location {
    margin-top: 10px;
    padding: 5px 10px;
    vertical-align: middle;
    border-bottom: 1px solid #dddddd;
    .right {
      float: right;
    }
  }
  .phone {
    margin-top: 10px;
    padding: 5px 10px;
    vertical-align: middle;    
    .right {
      float: right;
    }
  }
}
</style>
 