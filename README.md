# Domain-Sizing
A code written to read in an image created from a separate micromagnetic solver displaying a domain structure. It then establishes the number of red, blue and white pixels and finally calculates the average width of each region.

A domain structure for a material related to the orientation of its magnetic moment. The studied material possessed perpendicular magnetic anisotropy - the magnetisation of it is either oriented in or out of the plane. In the images produced these are represented by red/blue regions. The white area shows the region where the magnetisation flips from one orientation to the other, and is known as a domain wall. 

This code was written to calculate the average size of each red/blue region. To do this, it reads in the image and stores the number of regions which are red, blue and white. This is done by looking at the rgb values and using for statements to increment a counter. As red, blue and white have vastly different RGB values this was easy and allowed for all the pixels to be categorised as either red, blue or white, rounding them to the nearest one.

After this has been counted, the code then calculates the average size of the regions. To do this the code counts the number of pixels per row before it encounters a white one, stores the number then resets it and continues again from the next non-white pixel. It does this across all rows and then down all columns. As the shape of the regions does not matter, the average width is calculated from all the rows and columns together. Finally this is converted into physical units by converting it using the known physical width of the simulation. 

The results of the code can be seen graphed with a short analysis in the attached pdf file "Results.pdf"

