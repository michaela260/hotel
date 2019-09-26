1. What classes does each implementation include? Are the lists the same?
  Implementation A:
    CartEntry, ShoppingCart, Order
  Implementation B:
    CartEntry, ShoppingCart, Order
  So yes, the list of classes is the same for both implementations.

2. Write down a sentence to describe each class.
  CartEntry stores the unit price and quantity of each item in a shopping cart.
  ShoppingCart stores a list of all the types of items in an order.
  Order calculates the total price of a shopping cart order including sales tax.

3. How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
  Each ShoppingCart holds a list that is essentially a list of CartEntry instances. Order then sums the total of the items in an instance of ShoppingCart. 

4. What data does each class store? How (if at all) does this differ between the two implementations?
  See above question for what they store. The storage actually doesn't differ much between the two implementations.

5. What methods does each class have? How (if at all) does this differ between the two implementations?
  They all have initialize methods. The difference between the two implementations is that in Implentation B, CartEntry has its own method to store the price of each item (factoring in quantity), ShoppingCart has a method to sum the prices of each type of item, and then Order still has a total_price method but the subtotal has already been calculated within ShoppingCart, so it only has to add the sales tax.

6. Consider the Order#total_price method. In each implementation:
  Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
    In Implementation A, it is all in Order, but in Implementation B it is delegated.
  Does total_price directly manipulate the instance variables of other classes?
    In Implementation A it does but not in Implementation B.


7. If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
  It would affect the price calculation for each type of method. It would be muhc easier to implement in Implementation B because you could just modify the "price" method within Cart Entry to vary based on the quantity of items purchased.

8. Which implementation better adheres to the single responsibility principle?
  Implementation B better adheres to the single responsibility principle.


9. Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
  Implementation B is more loosely coupled because you are less likely to have to alter many of the classes to change one thing. There are fewer dependencies between the clases in Implementation B.