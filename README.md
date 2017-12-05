# ios_animate_shadows

Rotate CAShapeLayer with shadow but prevent shadow's rotation.
When we change transform property we change the angle of the layer and as result the shadow will be rotated also, but I want to make the shadow stable. It looks like we have stable source of light but rotate our shape.

I uses CAShapeLayer and CADisplayLink to calculate new shadowOffset. I don't know how to implement shadowOffset animation using by CAKeyFrameAnimation because I have 4 parts of different shadowOffset values and every time only one of them should be used.

![](https://github.com/waffleboot/ios_animate_shadows/blob/master/a1.png)
![](https://github.com/waffleboot/ios_animate_shadows/blob/master/a2.png)
