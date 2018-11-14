<template>
  <div v-if="books.length">
    <TopSwiper :tops="tops"></TopSwiper>
    <Card v-for="book in books" :key="book.id" :book="book">{{book.title}}</Card>
    <p v-if="!more" class="text-footer">没有更多数据</p>
  </div>
</template>

<script>
import { get } from '@/utils'
import Card from '@/components/BookCard'
import TopSwiper from '@/components/TopSwiper'

export default {
  data () {
    return {
      books: [],
      page: 0,
      more: true,
      tops: []
    }
  },
  mounted () {
    this.getList(true)
    this.getTop()
  },
  onPullDownRefresh () {
    this.getList(true)
    this.getTop()
  },
  onReachBottom () {
    if (!this.more) {
      return false
    }
    this.page = this.page + 1
    this.getList()
  },
  methods: {
    async getList (init) {
      if (init) {
        this.page = 0
        this.more = true
      }
      wx.showNavigationBarLoading()
      const books = await get('/weapp/booklist', {
        page: this.page
      })
      // this.books = book.list
      if (this.page > 0 && books.list.length < 6) {
        this.more = false
      }
      if (init) {
        this.books = books.list
        wx.stopPullDownRefresh()
      } else {
        // 下拉刷新，不能直接覆盖books，而是累加
        this.books = this.books.concat(books.list)
      }
      // wx.stopPullDownRefresh()
      wx.hideNavigationBarLoading()
    },
    async getTop () {
      // 获取轮播图数据
      const top = await get('/weapp/top')
      this.tops = top.list
    }
  },
  components: {
    Card,
    TopSwiper
  }
}
</script>

<style>

</style>
