#include "../include/paint.h"

void paintA(int a, int b)
{
	int x, y;
	for(x=0; x<8; x++)
	{
		for(y=0; y<16; y++)
		{
			if((x==3 || x==4) && (y>=1 && y<=4))
			{
				setPixel(x+a, y+b, 15);
			} else if((x==2 || x==5) && (y>=5 && y<=8))
			{
				setPixel(x+a, y+b, 15);
			} else if(y==9 && (x>=1 && x<=6))
			{
				setPixel(x+a, y+b, 15);
			} else if((x==1 || x==6) && (y>=10 && y<=12))
			{
				setPixel(x+a, y+b, 15);
			} else if(y==13 && (x>=0 && x<=7 && x!=3 && x!=4))
			{
				setPixel(x+a, y+b, 15);
			}
		}
	}
}

void paintMouse(int a, int b)
{
	int x, y;
	for(x=0; x<12; x++)
	{
		for(y=0; y<12; y++)
		{
			if(x+y<12)
			{
				setPixel(x+a, y+b, 15);
			} else if(x-y<=4 && x-y>=-4)
			{
				setPixel(x+a, y+b, 15);
			}
		}
	}
}



