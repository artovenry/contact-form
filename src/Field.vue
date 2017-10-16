<template lang="pug">
  .field
    slot(name="header")
    input(
      type="text"
      :value="value"
      @input="input($event.target.value)"
    )
    ul(v-show="notifying && errors.length")
      li(v-html="message" v-for="message in errors")
</template>


<script lang="coffee">
  export default
    props: ["value", "errors", "notifying"]
    methods:
      input: (value)->
        @$emit "update:value"     , value
        @$emit "update:notifying" , no

</script>

<style lang="sass">
</style>
