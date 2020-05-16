#include "blogger.h"

VALUE rb_mBlogger;

void
Init_blogger(void)
{
  rb_mBlogger = rb_define_module("Blogger");
}
