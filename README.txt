TL;DR: print the two STLs; take cloth 1" wide, one makes it into bias tape, (and you run it under an iron as it comes out), the other takes it and folds it in half, and you can run it into your sewing machine.  They have slots for feeding tape through to attach to your ironing board and sewing machine.

There are three things, here:
1. A reverse-engineered version of the "Half inch bias tape maker" by SamHillCreations ( https://www.thingiverse.com/thing:3034992 )
2. A file which loads the stls for, and modifies:
2.1. "Proper Bias Tape maker 1/2 " for sewing machine, hem" by Oscarko ( https://www.thingiverse.com/thing:3880491 )
2.2. "Double Fold Tape maker" by Arnie ( https://www.thingiverse.com/thing:4236663 )

#1 was clever - but unfortunately, it turned out to be pretty temperamental.  (If you still want to try it, I've added the ability to specify your input and output sizes, and/or how much overlap you want in the folded product.  Note that I never got it to work, though.)

So, I recommend you use the other two.  I've chopped off the wings of the original files and used slots to feed tape through, instead.  (These are to allow you to attach them to your ironing board or sewing machine.)  It cuts down the printing time pretty significantly, and makes "installation" more compact.  The openscad source file is btm_hacks.scad.

They work off a starting cloth width of 1".  You should be able to scale them up or down to whatever size you need.  (Though probably not too far down or it may not print right.  I also don't know if scaling up too far will give the cloth too much wiggle room to fold unintentionally, etc.  But it should work near 1", at least.)

Note that I wasn't able to feed the cloth straight from the first stage to the second - I had to run it under an iron as it left the first stage.  The second stage can be attached to a sewing machine so it feeds the folded cloth into the machine, though I found the folded cloth had a tendency to drift to the left or right and I had to leave ~two inches space so I could guide it with my fingers.

The work as a whole is licensed with Creative Commons Attribution Share Alike, I guess. I don't care too much if you attribute me or not, but the Share Alike thing in one of the above works means I have to use this one, too.

Hopefully these are useful!

-Erhannis
