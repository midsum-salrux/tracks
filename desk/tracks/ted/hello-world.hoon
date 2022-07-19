/-  spider
/+  *strandio
/+  *track
=,  strand=strand:spider
=,  strand-fail=strand-fail:libstrand:spider
=/  m  (strand ,vase)
^-  thread:spider
|=  arg=vase
^-  form:m
;<  now=@da  bind:m  get-time
=/  =cargo     [%tape data="hello world!" time=now]
=/  =delivery  [%tracks %hello-world cargo]
(pure:m !>(delivery))
