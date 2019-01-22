EmailValidator= require "email-validator"

export default
  namae: (val)->
    #必須入力
    #２０文字以内
    if val is ""
      return "必須入力です"
    else if /^[\u3000\u0020]+$/.test val
      return "必須入力です（スペース以外の文字を記入してください）"
    if val.length >20
      return "２０字以内で記入してください"
  furigana: (val)->
    #必須入力
    #３０文字以内
    if val is ""
      return "必須入力です"
    else if /^[\u3000\u0020]+$/.test val
      return "必須入力です（スペース以外の文字を記入してください）"
    else if not /^[\u3041-\u3096][\u3041-\u3096\u30FB-\u30FE]*$/.test val
      return "ひらがなで入力してください(スペース＊＊＊＊)"
    if val.length >30
      return "３０字以内で記入してください"
  email: (val)->
    #必須入力
    if val is ""
      return "必須入力です"
    else if /^[\u3000\u0020]+$/.test val
      return "必須入力です（スペース以外の文字を記入してください）"
    # あとはバリデーターに任せる
    if not EmailValidator.validate val
      return "メールアドレスを正しく記入してください"
  tel: (val)->
    # 必須入力
    if val is ""
      return "必須入力です"
    else if /^[\u3000\u0020]+$/.test val
      return "必須入力です（スペース以外の文字を記入してください）"
    if val isnt  "" and not /[\d\-\+\(\)]+$/.test val
      return "電話番号は半角数字<b>「0〜9」</b>と<b>ハイフン「-」</b>,<b>括弧「()」</b>,<b>プラス「+」</b>のみ使用可能です"
  yuubin: (val)->
    if val isnt "" and not /^[0-9\-]+$/.test val
      return "郵便番号は半角数字<b>「0〜9」</b>と<b>ハイフン「-」のみ使用可能です"
  address: (val)->
    if val isnt "" and val.length >50
      return "５０字以内で記入してください"
  subject: (val)->
    if val isnt "" and val.length >50
      return "５０字以内で記入してください"
  message: (val)->
    # 必須入力
    if val is ""
      return "必須入力です"
    else if /^[\u3000\u0020]+$/.test val
      return "必須入力です（スペース以外の文字を記入してください）"
