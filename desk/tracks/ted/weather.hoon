::
::  WEATHER
::  Returns the current weather
::  Like "Mainly clear, 84F"
::
::  PARAMETERS
::  %latitude
::  %longitude
::
::  DATA SOURCE
::  https://open-meteo.com/
::
/-  spider
/+  *strandio
/+  *track
=,  strand=strand:spider
=,  dejs:format
=,  strand-fail=strand-fail:libstrand:spider
=/  m  (strand ,vase)
|^  ted
++  decoder
  %-  ot
  :~  :-  %'current_weather'
      %-  ot
      :~  temperature+ne
          weathercode+ne
      ==
  ==
++  mine-json
  |=  =json
  ^-  tape
  =/  [temperature=@rd code=@rd]  (decoder json)
  =/  [temperature-sign=? temperature-value=@ud]
    (old:si (need (toi:rd temperature)))
  ;:  weld
      (describe-weather code)  ", "
      ?:  temperature-sign  ""  "-"
      (trip (ud-to-cord temperature-value))
      "F"
  ==
++  url
  |=  [latitude=tape longitude=tape]
  ;:  weld
    "https://api.open-meteo.com/v1/forecast?latitude="
    latitude
    "&longitude="  longitude
    "&current_weather=true&temperature_unit=fahrenheit"
  ==
++  describe-weather
  |=  code=@rd
  ^-  tape
  ::  https://open-meteo.com/en/docs
  =/  description-list
    :~  [.~0 "Clear sky"]
        [.~1 "Mainly clear"]
        [.~2 "Partly cloudy"]
        [.~3 "Overcast"]
        [.~45 "Fog"]
        [.~48 "Depositing rime fog"]
        [.~51 "Light drizzle"]
        [.~53 "Moderate drizzle"]
        ::  wtf is a heavy drizzle?
        [.~55 "Heavy drizzle"]
        [.~56 "Light freezing drizzle"]
        [.~57 "Heavy freezing drizzle"]
        [.~61 "Slight rain"]
        [.~63 "Moderate rain"]
        [.~65 "Heavy rain"]
        [.~66 "Light freezing rain"]
        [.~67 "Heavy freezing rain"]
        [.~71 "Slight snow fall"]
        [.~73 "Moderate snow fall"]
        [.~75 "Heavy snow fall"]
        [.~77 "Snow grains"]
        [.~80 "Slight rain showers"]
        [.~81 "Moderate rain showers"]
        [.~82 "Violent rain showers"]
        [.~85 "Slight snow showers"]
        [.~86 "Heavy snow showers"]
        [.~95 "Thunderstorm"]
        [.~96 "Thunderstorm"]
        [.~99 "Thunderstorm"]
    ==
  =/  descriptions
    (~(gas by *(map @rd tape)) description-list)
  (fall (~(get by descriptions) code) "Unknown conditions")
++  ted
  ^-  thread:spider
  |=  arg=vase
  ^-  form:m
  =/  =cart  !<(cart arg)
  =/  latitude  (find-param params.cart %latitude)
  =/  longitude  (find-param params.cart %longitude)
  ;<  now=@da  bind:m  get-time
  ;<  =json  bind:m  (fetch-json (url latitude longitude))
  =/  result  (mine-json json)
  =/  =delivery
    [taft.cart [%tape result now]]
  (pure:m !>(delivery))
--
