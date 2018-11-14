<template>
  <div class="counter-warp">
    <CommentList
      v-if="userInfo.openId" 
      type="user" 
      :comments="comments"
    >
    </CommentList>
    <div v-if="userInfo.openId">
      <div class="page-title">我的图书</div>
      <BookCard 
        v-for="book in books" 
        :key="book.id"
        :book="book"
      >
      </BookCard>
      <div v-if="!books.length">您还没有添加过图书</div>
    </div>
  </div>
</template>

<script>
import CommentList from '@/components/CommentList'
import BookCard from '@/components/BookCard'
import { get } from '@/utils'

export default {
  data () {
    return {
      comments: [],
      userInfo: {},
      books: []
    }
  },
  onShow () {
    // mounted 只触发一次
    if (!this.userInfo.openId) {
      let userInfo = wx.getStorageSync('userInfo')
      if (userInfo) {
        this.userInfo = userInfo
        this.init()
      }
    }
  },
  onPullDownRefresh () {
    this.init()
    wx.stopPullDownRefresh()
  },
  methods: {
    async getComments () {
      const comments = await get('/weapp/commentlist', {
        openid: this.userInfo.openId
      })
      this.comments = comments.list
    },
    async getBooks () {
      const books = await get('/weapp/booklist', {
        openid: this.userInfo.openId
      })
      this.books = books.list
    },
    init () {
      wx.showNavigationBarLoading()
      this.getComments()
      this.getBooks()
      wx.hideNavigationBarLoading()
    }
  },
  components: {
    CommentList,
    BookCard
  }
}
</script>

<style>

</style>
