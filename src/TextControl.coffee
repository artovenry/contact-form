export default
  inheritAttrs: off
  props:
    attr: {default: ""}
    id: {default: ""}
    inputAttrs: {default: ->{}}
  render: ($)->
    label= $ "label",
      "for": @$attrs.id, 
    $ "div", {class: "text-control-#{@$attrs.attr}"}, [
    ]
