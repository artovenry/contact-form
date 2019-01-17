<template lang="pug">
 #main
   .container
     //- autocomplete属性を使うためにはname属性が必要かな
     label(for="control-namae") 名前
     input#control-namae(type="text"   v-model="attrs.namae" name="full_name" autocomplete="name")

     label(for="control-furigana") ふりがな
     input#control-furigana(type="text"   v-model="attrs.furigana")

     label(for="control-email") メールアドレス
     input#control-email(type="email"  v-model="attrs.email" name="email" autocomplete="email")

     label(for="control-tel") 電話番号
     input#control-tel(type="tel"    v-model="attrs.tel" name="tel" autocomplete="tel")

     label(for="control-yuubin") 郵便番号
     input#control-yuubin(type="text" v-model="attrs.yuubin" name="postal-code" autocomplete="postal-code")

     label(for="control-address") 住所
     input#control-address(type="text"   v-model="attrs.address" name="address")

     label(for="control-subject") タイトル
     input#control-subject(type="text"   v-model="attrs.subject" name="subject")

     label(for="control-message") メッセージ
     textarea#control-message(v-model="attrs.message" name="message")
     input(type="submit" value="submit"   :disabled="!ready"  @click="send")
</template>
<style lang="scss" scoped>
  .container{width: 80vw;margin: 1rem auto;}

</style>
<script lang="coffee">
  import validators from "./validators"
  tainted= no
  attrs=
    namae: "", furigana: "", email: "", tel: "", yuubin: "", address: "", subject: "", message: ""
  errors= _.mapObject attrs, (item)->""
  watcher= _.inject _.keys(attrs), (memo, key)->
    _.extend memo,
      "attrs.#{key}":
        immediate: on
        handler: (val)->@errors[key]= validators[key](val) ? ''
  , {}
  export default
    data: ->{attrs, errors, tainted}
    computed:
      ready: ->@tainted and _.every @errors,(item)->item is ""
    watch: _.extend watcher,
      attrs: deep: yes, handler: (val)->@tainted= yes
    mounted: ->
      jQuery(".wpcf7").on "wpcf7invalid", (e)->
        console.log e.detail
    methods:
      send: -> do($=jQuery)=>
        $("#cf7-namae").val @namae
        $("#cf7-email").val @email
        $(".wpcf7-submit").click()
</script>
