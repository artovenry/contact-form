<template lang="pug">
  form(novalidate :class="{sending: sending}" autocomplete="on")
    field(autocomplete="name" attr="name" v-model="contact.name")
      header(slot="header") 名前

    field(v-model="contact.kana" attr="kana")
      header(slot="header") ふりがな

    field(autocomplete="email" attr="email" type="email" v-model="contact.email")
      header(slot="header") メールアドレス

    field(autocomplete="tel" attr="tel" type="tel" v-model="contact.tel")
      header(slot="header") 電話番号

    field(attr="message" v-model="contact.message")
      header(slot="header") メッセージ
      template(slot="control" scope="v")
        textarea(v-model="contact.message" @keydown="v.change($event.target.value)" @blur="v.change($event.target.value)" :disabled.prop="v.disabled")
    fieldset
      input(type="button" @click="submit" value="send" :disabled.prop="sending")
</template>


<script lang="coffee">
  import Field from "./Field.vue"
  import emailValidator from "email-validator"
  import validators from "./validators.coffee"
  axios = require "axios"
  export default
    data: ->
      contact   : name: "", kana: "", email: "", tel: "", message: ""
      validators : validators
      sending: no
    methods:
      greet: (res)->
        item.clear() for item in @$children
        console.log res.request
        alert "THANK YOU for your MESSAGE!"
        @$el.reset()
      explain: (res)->
        console.log res
      reset: ->
        item.disabled= no for item in @$children
        @sending= no

      submit: ->
        item.state= on for item in @$children
        if _.every(@validators, (item)->item.status is true)
          item.disabled= yes for item in @$children
          @sending= yes
          url = switch process.env.NODE_ENV
            when "development" then "http://#{SINATRA_HOST}:#{SINATRA_PORT}"
            else ""
          axios.post "#{url}/", @contact
          .then(@greet).catch(@explain).then(@reset)

    # DEV
    created: ->
      console.log process.env
      if process.env.NODE_ENV is "development"
        @contact[attr]= value for attr, value of contact=
          name: "sample name"
          kana: "さんぷるねーむ"
          email: "sample@hogehoge.com"
          message: """
            hogehoge
            hogehogehogehoge
          """
    components:
      field: Field

</script>

<style lang="sass">
  .sending
    background: gray
</style>
