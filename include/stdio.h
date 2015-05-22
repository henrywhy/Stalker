/* Some screen stuff.  */
/* The number of columns.  */
#define COLUMNS			80
/* The number of lines.  */
#define LINES			24
/* The attribute of an character.  */
#define ATTRIBUTE		7
/* The video memory address.  */
#define VIDEO			0xB8000

/* Variables.  */
/* Point to the video memory.  */
static volatile unsigned char *video;

/* Save the X position.  */
static int xpos;
/* Save the Y position.  */
static int ypos;

/* Put the character C on the screen.  */
void putchar (int c);

/* Format a string and print it on the screen, just like the libc
   function printf.  */
void printf (const char *format, ...);


