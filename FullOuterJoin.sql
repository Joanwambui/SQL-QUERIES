SELECT  a.Item AS ItemCart1,
        b.Item AS ItemCart2
FROM    #Cart1 a FULL OUTER JOIN
        #Cart2 b ON a.Item = b.Item;


Write an SQL statement to transform the following tables into the expected output.
  Item              Item
  -----             -----
  Sugar             Sugar
  Bread             Bread
  Juice             Butter
  Soda              Cheese
  Flour             Fruit

 Item Cart 1       Item Cart 2
 ------------      ------------
  Sugar             Sugar
  Bread             Bread
  Juice            
  Soda
  Flour
                    Butter
                    Cheese
                    Fruit
