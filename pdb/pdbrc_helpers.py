'''
Custom helper functions for debugging. Should be loaded in by the .pdbrc file.
'''

import time

import pprint
import numpy as np

# Try to load color libraries if installed
try:
    from pygments import highlight
    from pygments.lexers import PythonLexer
    from pygments.formatters import TerminalFormatter

    def colorize(code: str) -> str:
        return highlight(code, PythonLexer(), TerminalFormatter())

except ImportError:
    def colorize(code: str) -> str:
        return code

try:
    from rich import print as rprint
except ImportError:
    rprint = print


def dump(obj, maxlen=80):
    '''
    Pretty-print object repr with color.
    '''
    s = pprint.pformat(obj, width=maxlen)
    print(colorize(s))


def keys(obj):
    '''
    List dict keys or object attributes.
    '''
    if isinstance(obj, dict):
        rprint(f"[bold cyan]dict keys:[/bold cyan] {list(obj.keys())}")
    else:
        rprint(f"[bold cyan]attributes:[/bold cyan] {dir(obj)}")


def shape(x):
    '''
    Return shape/len for common containers and numpy arrays.
    '''
    if hasattr(x, "shape"):
        rprint(f"[bold magenta]shape:[/bold magenta] {x.shape}")
    elif hasattr(x, "__len__"):
        rprint(f"[bold magenta]len:[/bold magenta] {len(x)}")
    else:
        rprint("[bold magenta]no shape/len[/bold magenta]")


def norm(v):
    '''
    Euclidean norm of a 1D sequence.
    '''
    arr = np.array(v, dtype=float)
    return float(np.sqrt((arr**2).sum()))


def timer(func, *args, **kwargs):
    '''
    Quick timing for a function call inside ipdb.
    '''
    t0 = time.perf_counter()
    out = func(*args, **kwargs)
    t1 = time.perf_counter()
    rprint(f"[bold yellow]{func.__name__} took {t1 - t0:.6f}s[/bold yellow]")
    return out
