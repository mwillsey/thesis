#!/usr/bin/env python3

import matplotlib
import matplotlib.pyplot as plt

matplotlib.rcParams['text.usetex'] = True
matplotlib.rcParams.update({"font.size": 12})

data = [
    ('initial Racket\nimplementation', 83.7*60, 98.1),
    ('+ batching', 49.4, 68.7),
    ('+ rebuilding', 22.4, 48.8),
    ('egg', 1.4, 4.8),
]

names, sec, pct = map(list, zip(*data))

x = range(len(names))

bars = plt.bar(x, sec, log=True, tick_label=names)
for i, (bar, p) in enumerate(zip(bars, pct)):
    h = bar.get_height()
    if i == 0:
        plt.annotate(
            '{}\n({}% of total run time)'.format(h, p),
            xy=(bar.get_x(), h),
            xytext=(0, 3),  # 3 points vertical offset
            textcoords="offset points",
            ha='left', va='bottom'
        )
    else:
        plt.annotate(
            '{}\n({}%)'.format(h, p),
            xy=(bar.get_x() + bar.get_width() / 2, h),
            xytext=(0, 3),  # 3 points vertical offset
            textcoords="offset points",
            ha='center', va='bottom'
        )

plt.ylim(1, 10 ** 4.3)
plt.ylabel('Minutes spent in simplification')
plt.tight_layout()
plt.savefig('_build/herbie.pdf')
