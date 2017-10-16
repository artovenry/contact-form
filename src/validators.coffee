EmailValidator = require "email-validator"
S = require "string"

module.exports=
  name: (value)->[
    if S(value).isEmpty() then "必須入力です"
  ]
  kana: (value)->[
    if S(value).isEmpty() then "必須入力です"
    else if not /^[\u3041-\u3096][\u3041-\u3096\u30FB-\u30FE]*$/.test value then  "全角ひらがなで記入してください"
    if /[\u3000|\u0020]/.test value then "スペースは使用できません"
  ]
  email: (value)->[
    if S(value).isEmpty() then "必須入力です"
    else if not EmailValidator.validate value then "メールアドレスの形式が無効です"
  ]
  tel: (value)->[
    if value isnt  "" and not /[\d\-\+\(\)]+$/.test value
      "電話番号は半角数字<b>「0〜9」</b>と<b>ハイフン「-」</b>,<b>括弧「()」</b>,<b>プラス「+」</b>のみ使用可能です"
  ]
  message: (value)->[
    if S(value).isEmpty() then "必須入力です"
  ]
