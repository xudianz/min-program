<template>
  <div class="swiper">
    <swiper
      :indicator-dots="true"
      indicator-color="#EA5A49"
      :autoplay="true"
      :interval="6000"
      :duration="500"
      :circular="true"
    >
      <div v-for="(top, imgindex) in imgUrls" :key="imgindex">
        <swiper-item>
          <img v-for="img in top" :key="img.id" mode="aspectFit" :src="img.image" class="slide-image" @click="bookDetail(img)"/>
        </swiper-item>
      </div>
    </swiper>
  </div>
</template>

<script>
export default {
  props: {
    tops: {
      type: Array,
      default: []
    }
  },
  computed: {
    imgUrls () {
      let res = this.tops
      return [res.slice(0, 3), res.slice(3, 6)]
    }
  },
  methods: {
    bookDetail (item) {
      wx.navigateTo({
        url: '/pages/Detail/main?id=' + item.id
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.swiper {
  margin-top: 5px;
  .slide-image {
    width: 33.3333%;
    height: 250rpx;
  }
}
</style>
