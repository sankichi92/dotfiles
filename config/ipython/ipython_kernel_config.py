# Configuration file for ipython-kernel.

c = get_config()  #noqa

# https://ipython.readthedocs.io/en/stable/api/generated/IPython.display.html#IPython.display.set_matplotlib_formats
# https://github.com/ipython/matplotlib-inline/blob/master/matplotlib_inline/backend_inline.py
c.InlineBackend.figure_formats = {'retina'}
