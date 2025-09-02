from ranger.api import hook_init

def hook_init(fm):
    import signal
    def redraw_on_resize(sig, frame):
        fm.ui.redraw_window()
    signal.signal(signal.SIGWINCH, redraw_on_resize)

