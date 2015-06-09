final int SCALE = 45, xbet = 5, ybet = 5;
final int X_OFFSET = 5, Y_OFFSET = 2;
Boardobjects [][] board;
int grid_width = 9;
int grid_length = 9;
int num_mines = 10;
boolean playing = true;

void setup()
{
  size(500,500);
  background(255);
  createboard();
  setit();
  drawboard();
}

void mouseClicked()
{
  if(playing)
  {
  int row_click = pixel_to_row(mouseY);
  int column_click = pixel_to_column(mouseX);
  updateboard(row_click, column_click);
  playing = win_or_lose(row_click, column_click);
  }
  if(playing)
  {
  drawboard();
  }
}

void draw()
{
 fill(255);
 stroke(255);
 rect(450, 400, 60, 60);
 int row = pixel_to_row(mouseX);
 int column = pixel_to_column(mouseY);
 fill(0);
 textSize(32);
 text( ""+ row , 460, 460);
 text( ""+ column , 480, 460);
 text( ""+ board[row][column].num , 480, 430);
  
}

 void createboard()
  {
    board = new Boardobjects[grid_width][grid_length];
    for(int i = 0; i < grid_width; i++)
    {
      for( int j = 0; j < grid_length; j++)
      {
        board[i][j] = new Boardobjects(i, j);
      }
    }
  }
  
  void setit()
  {
    int mine_counter = 0;
    boolean mines_unfull = true;
    while( mines_unfull)
    { 
      if( mine_counter == num_mines)
      {
        mines_unfull = false;
      }
      int minex = int(random(grid_width - 1));
      int miney = int(random(grid_length - 1));
      if(board[minex][miney].mine == false)
      {
        board[minex][miney].mine = true;
        mine_counter += 1;
      }
    }
      for(int i=0; i<grid_width; i++)
      {
        for (int j=0; j<grid_length; j++)
        {
          if(board[i][j].mine == false)
          {
            final int [] delta_y1={-1, -1, -1, 0, 0, 1, 1, 1};
            final int [] delta_x1={-1, 0, 1, -1, 1, -1, 0, 1};
            int mine_count=0;
            for (int k=0; k<8; k++)
            {
              int y_new= i+ delta_y1[k];
              int x_new = j+ delta_x1[k];
                if(y_new <= grid_length-1 &&
                  y_new >= 1 &&
                  x_new <= grid_width -1 &&
                  x_new >= 1 &&
                  board[y_new][x_new].mine == true )
                {
                  mine_count++;
                }
            }
          board[i][j].num = mine_count;
          board[i][j].number = Integer.toString(mine_count);
        }
        }
      }
  }

  void drawboard()
  {
    for( int i = 0; i < grid_width; i++)
    {
      for( int j = 0; j < grid_length; j++)
      {
         board[i][j].draw_boardobject();
      }
    }
  }

    boolean win_or_lose(int x1, int y1)
    {
      int wincounter = 0;
        if(mouseButton == LEFT && board[y1][x1].mine)
        {
          board[y1][x1].covered = false;
          fill(0);
          textSize(30);
          text("You hit a mine. Game over.", 20, 250);
          return false;
        }
      else
      {
        for(int i=1; i<grid_width; i++)
        {
          for (int j=1; j<grid_length; j++)
          {
            if(board[i][j].mine && board[i][j].flag)
            {
              wincounter ++;
            }
          }
        }
        if(wincounter == num_mines)
        {
          fill(0);
          textSize(30);
          text("You found all the mines!", 20, 250);
          return false;
        }
      }
      return true;
    }
    

    void updateboard(int x1, int y1)
    {
      if(x1 < 0 || y1 < 0 || y1 > grid_length - 1 || x1 > grid_width - 1)
      {
        return;
      }
      if(mouseButton == LEFT)
      {
        if(!board[y1][x1].mine && (!board[y1][x1].covered || board[y1][x1].num != 0))
        {
          board[y1][x1].covered = false;
          return;
        }
            else if(!board[y1][x1].mine && board[y1][x1].num == 0)
            {
              board[y1][x1].covered = false;
              for (int k=0; k<8; k++)
              {
                final int [] delta_y1={-1, -1, -1, 0, 0, 1, 1, 1};
                final int [] delta_x1={-1, 0, 1, -1, 1, -1, 0, 1};
                int y_new= y1+ delta_y1[k];
                int x_new = x1+ delta_x1[k];
                updateboard(x_new, y_new);

              }

            }
        }
        if(mouseButton == RIGHT)
        {
          board[y1][x1].flag = true;
        }
      }


class Boardobjects
{
  boolean flag = false;
  boolean mine = false;
  int num = 0, row, column;
  boolean covered = true;
  final float bWidth  =  (.5) * SCALE;
  final float bHeight = (1.5) * SCALE ;
  String number;

      public Boardobjects(int init_x, int init_y )
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
          text( ""+ number , row_to_pixel(row) + bWidth / 2, column_to_pixel(column) + bHeight / 2 );
          }  
         
       }
    
  }
  
   boolean click_inside( int cx, int cy )
  {
    boolean x1 = cx > row * SCALE; 
    boolean x2 = cx < ( row * SCALE + bWidth ); 
    boolean y1 = cy > column * SCALE; 
    boolean y2 = cy < ( column * SCALE + bHeight );
    return x1 && x2 && y1 && y2;
  }
}

   int pixel_to_row(int pixel_value)
 {
    int row_value = (pixel_value - X_OFFSET)/(SCALE + xbet);
    return row_value; 
 }
 
   int pixel_to_column(int pixel_value)
 {
    int column_value = (pixel_value - X_OFFSET)/(SCALE + ybet);
    return column_value; 
 }
   int row_to_pixel(int row_value)
 {
    int pixel_value = row_value * (SCALE + xbet) + X_OFFSET;
    return pixel_value; 
 }
 
   int column_to_pixel(int column_value)
 {
    int pixel_value = column_value * (SCALE + ybet) + Y_OFFSET;
    return pixel_value; 
 }

