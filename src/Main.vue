<template lang="pug">
 #main
   .container
     //- autocomplete属性を使うためにはname属性が必要かな
     label(for="control-namae") 名前
     input#control-namae(type="text"   v-model="attrs.namae"  name="full_name" autocomplete="name"  @blur="blr($event.target.value)")
     .error(v-show="errors.namae !== ''  && tainted === true"  v-html="errors.namae")

     label(for="control-furigana") ふりがな
     input#control-furigana(type="text"   v-model="attrs.furigana")
     .error(v-show="errors.furigana !== ''"  v-html="errors.furigana")

     label(for="control-email") メールアドレス
     input#control-email(type="email"  v-model="attrs.email" name="email" autocomplete="email")
     .error(v-show="errors.email !== ''"  v-html="errors.email")

     label(for="control-tel") 電話番号
     input#control-tel(type="tel"    v-model="attrs.tel" name="tel" autocomplete="tel")
     .error(v-show="errors.tel !== ''"  v-html="errors.tel")

     label(for="control-yuubin") 郵便番号
     input#control-yuubin(type="text" v-model="attrs.yuubin" name="postal-code" autocomplete="postal-code")
     .error(v-show="errors.yuubin !== ''"  v-html="errors.yuubin")

     label(for="control-address") 住所
     input#control-address(type="text"   v-model="attrs.address" name="address")
     .error(v-show="errors.address !== ''"  v-html="errors.address")

     label(for="control-subject") タイトル
     input#control-subject(type="text"   v-model="attrs.subject" name="subject")
     .error(v-show="errors.subject !== ''"  v-html="errors.subject")

     label(for="control-message") メッセージ
     textarea#control-message(v-model="attrs.message" name="message")
     .error(v-show="errors.message !== ''"  v-html="errors.message")

     input(type="submit" value="submit"   :disabled="!ready"  @click="send")
</template>
<style lang="scss" scoped>
  .container{width: 80vw;margin: 1rem auto;}
  .error{color: red;font-size: 80%;}

</style>
<script lang="coffee">
  import checkers from "./checkers"
  attrs=
    namae: "", furigana: "", email: "", tel: "", yuubin: "", address: "", subject: "", message: ""
  errors= _.mapObject attrs, (item)->""
  tainted= no
  watcher= _.inject _.keys(attrs), (memo, key)->
    _.extend memo,
      "attrs.#{key}":
        immediate: on
        handler: (val)->@errors[key]= validators[key](val) ? ''
  , {}
  export default
    data: ->{attrs, errors, tainted}
    computed:
      # ready: ->@tainted and _.every @errors,(item)->item is ""
      ready: ->yes
    watch:
      "attrs.namae":
        immediate: on
        handler: (val)->@errors.namae= checkers.namae(val) ? ""
    methods:
      blr: (val)->
        return if @tainted
        return if val is "" #<--- initial state
        @tainted= yes; Object.freeze @tainted;
      send: -> do($=jQuery)=>
        $("#cf7-namae").val @namae
        $("#cf7-email").val @email
        $(".wpcf7-submit").click()

    mounted: ->
      # jQuery(".wpcf7").on "wpcf7invalid", (e)->
      #   console.log e.detail
</script>
