// 工具函数库

import config from '../config'

export function get (url, data) {
  return request(url, 'GET', data)
}

export function post (url, data) {
  return request(url, 'POST', data)
}

function request (url, method, data) {
  return new Promise((resolve, reject) => {
    wx.request({
      url: config.host + url,
      method,
      data,
      success: function (res) {
        let data = res.data
        if (data.code === 0) {
          resolve(data.data)
        } else {
          showModal('失败', data.data.msg)
          reject(data)
        }
      }
    })
  })
}

export function showSuccess (text) {
  wx.showToast({
    title: text,
    icon: 'success'
  })
}

export function showModal (title, content) {
  wx.showModal({
    title,
    content,
    showCancel: false
  })
}
