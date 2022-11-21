|%
::  desk is where the thread is stored
::  ted is the name of the thread
::  slug distinguishes this set of parameters
::  you can write this as /desk/ted/slug
+$  taft  [desk=@tas ted=@tas slug=@tas ~]
::  params are not a map because they have a user-definable order
+$  param  [key=@tas value=tape]
+$  track
  [=taft frequency=@dr name=tape params=(list param) results=(list cargo)]
+$  cargo
  $%  [%ud data=@ud time=@da]
      [%rd data=@rd time=@da]
      [%bool data=? time=@da]
      [%tape data=tape time=@da]
  ==
::  a cart is the argument passed to your thread
+$  cart  [=taft params=(list param)]
::  your thread should return a delivery
+$  delivery  [=taft =cargo]
+$  taft-timer  [=taft time=@da]
--
