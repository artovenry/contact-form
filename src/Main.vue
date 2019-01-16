<template lang="pug">
 #main
   .container
     //- autocomplete属性を使うためダミーのname属性を追加
     input(v-model="namae" name="_autocomplete1" autocomplete="name")
     input(v-model="furigana")
     input(v-model="email" autocomplete="email" name="_autocomplete2")
     input(type="submit" value="submit"  v-show="ready"  :disabled="!ready"  @click="send")
</template>
<style lang="scss" scoped>
  .container{
    width: 80vw;margin: 1rem auto;
  }
  .wpcf7{display: block;}
</style>
<script lang="coffee">
  export default
    data: ->
      namae: "", furigana: "", email: ""
    computed:
      ready: ->yes
    mounted: ->
      jQuery(".wpcf7").on "wpcf7invalid", (e)->
        console.log e.detail
    methods:
      send: -> do($=jQuery)=>
        $("#cf7-namae").val @namae
        $("#cf7-email").val @email
        $(".wpcf7-submit").click()
</script>
