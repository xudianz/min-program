<template>
  <div class="container">
    <button class="userinfo" open-type="getUserInfo" @getuserinfo="bindGetUserInfo" plain>
      <img :src="userInfo.avatarUrl" alt="">
      <p>{{userInfo.nickName}}</p>
    </button>
    <div class="progress">
      <YearProgress></YearProgress>
    </div>
    <!-- v-if="userInfo.openId" -->
    <button @click="scanBook" class="btn">添加图书</button>
  </div>
</template>

<script>
import qcloud from 'wafer2-client-sdk'
import config from '@/config'
import { showSuccess, post, showModal } from '@/utils'
import YearProgress from '@/components/YearProgress'

export default {
  data () {
    return {
      userInfo: {
        avatarUrl: '../../../static/img/unlogin.png',
        nickName: '点击登录'
      }
    }
  },
  onShow () {
    let userinfo = wx.getStorageSync('userInfo')
    if (userinfo) {
      this.userInfo = userinfo
    }
  },
  methods: {
    bindGetUserInfo (e) {
      let _this = this
      let user = wx.getStorageSync('userInfo')
      if (!user) {
        qcloud.setLoginUrl(config.loginUrl)
        qcloud.login({
          success: function (userInfo) {
            _this.userInfo = userInfo
            console.log('登录成功', userInfo)
            showSuccess('登录成功') // toast
            wx.setStorageSync('userInfo', userInfo)
          },
          fail: function (err) {
            console.log('登录失败', err)
          }
        })
      } else {
        let result = wx.getStorageSync('userInfo')
        _this.userInfo = result
      }
      // console.log(e.mp.detail)
    },
    scanBook () {
      let self = this
      wx.scanCode({
        success (res) {
          console.log(res)
          let result = res.result
          if (result) {
            self.addBook(result)
          }
        }
      })
    },
    async addBook (isbn) {
      const res = await post('/weapp/addbook', {
        isbn,
        openid: this.userInfo.openId
      })
      showModal('添加成功', `${res.title} 添加成功`)
    }
  },
  components: {
    YearProgress
  }
}
</script>

<style lang="scss" scoped>
.container {
  padding: 0 30rpx;
  .userinfo{
    margin-top: 100rpx;
    text-align: center;
    background: #fff;
    border: 0;
    img{
      width: 128rpx;
      height: 128rpx;
      margin: 20rpx;
      border-radius: 50%;
    }
  }
  .progress {
    width: 100%;
    margin: 16rpx 0;
  }
}
</style>
