<template lang="pug">
  form(novalidate :class="{sending: sending}")
    field(autocomplete="name" v-bind="contact.name")
      header(slot="header") 名前

    field(v-bind="contact.kana")
      header(slot="header") ふりがな

    field(autocomplete="email" type="email" v-bind="contact.email")
      header(slot="header") メールアドレス

    field(autocomplete="tel" type="tel" v-bind="contact.tel")
      header(slot="header") 電話番号

    field(v-bind="contact.message")
      header(slot="header") メッセージ
      template(slot="control" scope="v")
        textarea(v-model="contact.message.value" @keydown="v.change($event.target.value)" @blur="v.change($event.target.value)" :disabled.prop="v.disabled")
    fieldset
      input(type="button" @click="submit" value="send" :disabled.prop="sending")
</template>


<script lang="coffee">
  import Field from "./Field.vue"
  import emailValidator from "email-validator"
  axios = require "axios"
  export default
    data: ->
      sending: no
      contact:
        name:
          value: ""
          validate: (value)->[
            if value is "" then "必須入力です"
          ]
        kana:
          value: ""
          validate: (value)->[
            if value is "" then "必須入力です"
            else if not /^[\u3041-\u3096][\u3041-\u3096\u3000\u30FB-\u30FE]+$/.test value then  "全角ひらがなで記入してください"
          ]
        email:
          value: ""
          validate: (value)->[
            if value is "" then "必須入力です"
            else if not emailValidator.validate value then "メールアドレスの形式が無効です"
          ]
        tel:
          value: ""
          validate: (value)->[
            if value isnt  "" and not /[\d\-\+\(\)]+$/.test value
              "電話番号は半角数字<b>「0〜9」</b>と<b>ハイフン「-」</b>,<b>括弧「()」</b>,<b>プラス「+」</b>のみ使用可能です"
          ]
        message:
          value: ""
          validate: (value)->[
            if value is "" then "必須入力です"
          ]
    methods:
      clearAll: ->_.chain(@contact).values().each (item)->item.value= ""
      greet: (res)->
        item.state=off for item in @$children
        @clearAll()
        alert "THANK YOU for your MESSAGE!"
        @$el.reset()
      explain: (res)->
        console.log res
      reset: ->
        item.disabled= no for item in @$children
        @sending= no
      submit: ->
        item.state= on for item in @$children
        if _.every(@children, (item)->item.status is true)
          item.disabled= yes for item in @$children
          @sending= yes
          url = switch process.env.NODE_ENV
            when "development" then "http://#{SINATRA_HOST}:#{SINATRA_PORT}"
            else ""
          axios.post "#{url}/", _.mapObject @contact, (item)->item.value
          .then(@greet).catch(@explain).then(@reset)
</script>

<style lang="sass">
  .sending
    background: gray
</style>
