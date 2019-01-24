Control=
  functional: on
  props: ["tag", "attrs", "value"]
  render: (h, context)->
    {tag, attrs, value}= context.props
    switch tag
      when 'input'
        attrs= _.defaults attrs, type: 'text'
        style= border: 0, "border-bottom": "1px dotted black"
      when 'textarea'
        attrs= attrs
        style= border: "1px dotted black"
    _.extend style, context.data.style
    h tag, {attrs: attrs, style: style, domProps: {value: value}, on: context.listeners}

BaseComponent=
  inheritAttrs: off
  controlTagName:null #<---control要素のタグ名になる
  props: ["value", "error", "label","blank", "controlAttrs"]
  data: ->tainted: no, showError: no
  methods:
    input: (e)->
      @$emit "update:value", e.target.value
      @showError= no
      @tainted= yes; Object.freeze @$tainted

      # 入力が終わって、ちょっと経ったらエラーを表示する
      # これ、、うざいね
      # tryToShowError= =>@showError= yes if @error? and @tainted
      # do _.debounce(tryToShowError, 2000)
    blur: (e)->
      @showError= yes if @error? and @tainted
  render: (h)->
    # reset系のcssライブラリの影響があるかもなので、label, input, にはdisplayプロパティを当てておく
    <div
      class={['control', if @blank is false then 'control-required']}
      style="display: flex;align-items: baseline"
    > {###コントロールの文字と合わせるためにbaselineにする###}

      {if @blank is false
        <span style="font-size:.5rem;color: red;margin-right:.3rem;"> &#x273D;</span>}
      <label class="control-label"  for={@controlAttrs.id} style="display:inline">{@label}</label>
      <span
        style={
          flex: "auto" #コントロールとエラーの部分は横いっぱいに伸ばす
          display: "inline-flex"
          "flex-flow": "column" #エラーはコントロールの真下に置く
          "margin-left": "1rem"
        }
      >
        <span> {### baselineでラベルとコントロールを揃えてるためか、入力時にラベルががくがくすることがある。それを防ぐためにコントロールをスパンで囲む###}
          <Control tag={@$options.controlTagName}
            attrs={@controlAttrs} value={@value}
            onInput={@input} onBlur={@blur}
            style={ # コンポーネント内でマージされるのでハッシュにしとく
              "width": "100%" #サイズを親のスパンに依存させるため
              "display": "inline-block"
              "line-height": 1.7
            }
          />
        </span>
        <span
          class="control-error"
          style={
            visibility: if @showError then 'visible' else 'hidden'
            "line-height": 2
          }
          domPropsInnerHTML={@error ? '&nbsp;'}
        />
      </span>
    </div>


export TextControl= extends: BaseComponent, controlTagName: "input"
export TextAreaControl= extends: BaseComponent, controlTagName: "textarea"
