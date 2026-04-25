cat chapters/03_funktionen.tex | head -n 78 > temp.tex
cat << 'INNEREOF' >> temp.tex
\begin{fulltablebox}{C}
    $\displaystyle \sin\left(\frac{x}{2}\right) = \pm\sqrt{\frac{1-\cos(x)}{2}}, \quad \cos\left(\frac{x}{2}\right) = \pm\sqrt{\frac{1+\cos(x)}{2}}$ \\ \hline
    \ZSFrowColor
    $ \begin{aligned}
        \sin(2x) &= 2\sin(x)\cos(x) \\
        \cos(2x) &= \cos^2(x) - \sin^2(x) = 1 - 2\sin^2(x) \\
        \tan(2x) &= \frac{2\tan(x)}{1 - \tan^2(x)}
    \end{aligned} $ \\ \hline
    $ \begin{aligned}
        \cos(3x) &= 4\cos^3(x) - 3\cos(x) \\
        \sin(3x) &= 3\sin(x) - 4\sin^3(x)
    \end{aligned} $
\end{fulltablebox}

\begin{fulltablebox}{C}
    $\displaystyle \sin(t)\cos(s) = \frac{1}{2}(\sin(t+s) + \sin(t-s))$ \\ \hline
    \ZSFrowColor
    $ \begin{aligned}
        \cos(a \pm b) &= \cos(a)\cos(b) \mp \sin(a)\sin(b) \\
        \sin(a \pm b) &= \cos(b)\sin(a) \pm \sin(b)\cos(a)
    \end{aligned} $
\end{fulltablebox}
INNEREOF
cat chapters/03_funktionen.tex | tail -n 13 >> temp.tex
mv temp.tex chapters/03_funktionen.tex
