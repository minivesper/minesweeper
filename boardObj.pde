
/* class boardObj
  Each box in the minesweeper grid is an object
  Methods:
  Constructor - boardObj(row,column)
  draw_bbox(boolean covered) - Draws the surrounding box colored based on covered value
  draw_boardobject() - Draws whole box with text
  calc_box() - Figures out the number (mine count) for this box
*/
class boardObj
{
  boolean flag = false;
  boolean mine = false;
  int num = 0, row, column;
  boolean covered = true;
  final float bWidth  =  (.5) * SCALE;
  final float bHeight = (1.5) * SCALE ;

      public boardObj(int init_x, int init_y )
      {        
        row = init_x;
        column = init_y;
      }
     
     void draw_bbox(boolean covered)
     {
       if(covered)
       {
         fill( 0, 10, 100 );
         stroke( 10, 100, 200 );
       }
       else
       {
         fill( 100, 50, 100 );
         stroke( 10, 100, 200 );
       }
       rect(row * (SCALE + xbet) + X_OFFSET, column * (SCALE + ybet) + Y_OFFSET, SCALE, SCALE);
     }    
      
     
     void draw_boardobject()
     {
       draw_bbox(covered);
    
       if(covered)
       {
         if(flag)
         {
            fill(0);
            text( ""+ "F" , row_to_pixel(row) + bWidth / 2, column_to_pixel(column) + bHeight / 2 );
         }
       }
       else
       {
          if(mine)
          {
            fill(0);
            text( ""+ "M" , row_to_pixel(row) + bWidth / 2, column_to_pixel(column) + bHeight / 2 );
          }
          else if(num != 0)
          {
           fill(0);
           text( str(num) , row_to_pixel(row) + bWidth / 2, column_to_pixel(column) + bHeight / 2 );
          }   
       }
     }
       
     void calc_box()
     {
       if(mine == false)
       {
         final int [] delta_y1={-1, -1, -1, 0, 0, 1, 1, 1};
         final int [] delta_x1={-1, 0, 1, -1, 1, -1, 0, 1};
         num=0;
         
         for (int k=0; k<8; k++)
         {
           int y_new = row + delta_y1[k];
           int x_new = column + delta_x1[k];
           if (!(y_new < 0) && (y_new < grid_length) && !(x_new < 0) && (x_new < grid_width))
           {
             if(board[y_new][x_new].mine == true)
             {           
               num++;
             }
            }
         }
       }
    }
}
