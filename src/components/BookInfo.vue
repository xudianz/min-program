<template>
  <div class="bookinfo">
    <div class="thumb">
      <img mode="aspectFill" class="back" :src="info.image">
      <img mode="aspectFit" :src="info.image" class="img">
      <div class="info">
        <div class="title">{{info.title}}</div>
        <div class="author">{{info.author}}</div>
      </div>
    </div>
    <div class="detail">
      <img :src="userinfo.image" class="avatar" mode="aspectFit">
      {{userinfo.name}}
      <div class="right text-primary">
        {{info.rate}}分
        <Rate :rate="info.rate"></Rate>
      </div>
    </div>
    <div class="detail">
      {{info.publisher}}
      <div class="right">{{info.price}}</div>
    </div>
    <div class="tags">
      <div class="badge" v-for="tag in info.tags" :key="tag">{{tag}}</div>
    </div>
    <div class="summary">
      <p v-for="(summary, index) in info.summary" :key="index">{{summary}}</p>
    </div>
  </div>
</template>

<script>
import Rate from '@/components/Rate'

export default {
  props: {
    info: {
      tyope: Object,
      default: {}
    }
  },
  computed: {
    userinfo () {
      return this.info.user_info || {}
    }
  },
  components: {
    Rate
  }
}
</script>

<style lang="scss" scoped>
.bookinfo {
  font-size: 14px;
  .tags {
    padding: 0 5px;
    .badge {
      display: inline-block;
      margin: 5px;
      padding: 5px;
      border-radius: 5px;
      border: 1px solid #EA5149;
      color: #EA5149;
    }
  }
  .summary {
    padding: 0 15px;
    margin-top: 10px;
    p {
      text-indent: 2em;
    }
  }
  .thumb {
    width: 100%;
    height: 500rpx;
    overflow: hidden;
    position: relative;
    .back {
      filter: blur(10px);
      width: 100%;
    }
    .img {
      position: absolute;
      left: 0%;
      top: 30rpx;
      width: 100%;
      height: 300rpx;
    }
    .info {
      color: #fff;
      position: absolute;
      width: 100%;
      left: 0;
      top: 350rpx;
      text-align: center;
      .title {
        font-size: 20px;
      }
      .author {
        font-size: 14px;
      }
    }
  }
  .right {
    float: right;
  }
  .detail {
    padding: 5px 10px 0;
    .avatar {
      width: 20px;
      height: 20px;
      border-radius: 50%;
      vertical-align: middle;
    }
  }
}
</style>

