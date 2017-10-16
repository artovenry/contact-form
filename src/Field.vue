<template lang="pug">
  .field
    slot(name="header")
    slot(name="control" :input="input" :value="value")
      input(
        :type="type"
        :value="value"
        @input="input($event.target.value)"
        :autocomplete="autocomplete"
      )
    slot(name="messages")
      ul(v-show="notifying && errors.length")
        li(v-html="message" v-for="message in errors")
</template>


<script lang="coffee">
  export default
    props:
      value       : ""
      type        : default: "text"
      autocomplete: default: "off"
      errors      : default: ->[]
      notifying   : default: off
    methods:
      input: (value)->
        @$emit "update:value"     , value
        @$emit "update:notifying" , no

</script>

<style lang="sass">
</style>
