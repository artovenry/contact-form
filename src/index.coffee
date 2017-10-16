import Vue from "vue/dist/vue.esm.js"
import Form from "./Form.vue"

vm= new Vue
  render: (h)->h(Form)
document.addEventListener "DOMContentLoaded", (->vm.$mount("#site"))
