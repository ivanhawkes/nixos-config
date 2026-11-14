# Background

## AI Disclosure

I have tried on at least two other occasions to switch my desktop to NixOS. Each time I hit a wall
and eventually caved in to the tempting comfort of my old Ubuntu and Debian distributions. When I
accidentally tanked my Debian 13 Trixie desktop with a botched install of Hyprland and a mix
of 'Unstable', 'Testing' and 'Backports', I knew it was time to give NixOS another shot.

I started from my last build, which I kept in a git repository for safe keeping. It was a fast
way to get a lot of my environment ready, but was pretty rough and didn't have any style to it.
I wanted something fast, sleek, reproducible and stylish. If I'm putting in this level of work
again the results need to bring joy.

Lucky, I had just been experimenting with AI to evaluate it for general purpose work. The
evaluation used a mix of publicly available 'free' AI from Google, and the ISTA-DASLab/Qwen3.8-27B-GSQ-RCO-GGUF model
that I could run locally.

Installing the [Pi Coding Harness](https://pi.dev/) into the project folder gave it unfettered
access to both the project and my machine. I fed it vital machine information from Fastfetch,
which I also supplied to Google, along with my complete configuration so Google could assist
with the edits, which were sometimes a little vague thanks to the way the files are broken out.

Step by step, sometimes with extremely frustrating build-breaking issues to deal with, I made
it work and feel the way I wanted.

At many points both AIs failed. Some of the more common failures were:

- outdated information from the fast pace of change in NixOS + Niri + Noctalia. This was typically
  felt in the form of settings, parameters, flags, etc. all being deprecated, switched to a
  new name, or their signature being changed.
- Local AI often stuttered as it found NixOS and Niri not accepting scripts it wrote, with the
  apostrophe character often being at fault. Quoting would cause unusual failure points, but
  the model would persist and usually get to the end goal.
- going off on wild tangents. Watching the local AI open the Nix packages, start reading source
  code, and build Python programs to execute arbitrary code was both thrilling and chilling.
- running out of context and needing to compact. The AI would spend so long on reasoning
  that it would need to stop and hit itself in the head with a hammer before it could
  continue.

### Findings

The local AI has a huge advantage because it runs in a harness which gives it **intimate knowledge
of my system** and **can run arbitrary code of its own design**.

You can level the playing field for Google AI by feeding it a tarball of your configuration,
a copy of the output from fastfetch, and the error messages that inevitably litter your screen
as you run through the fine-tuning process. But that's still a lot of stop and start, and
cut and paste.

Google AI was multiple times faster, and has the benefit of decades of scraping the internet
for backfill. Local AI keeps Google from having a permanent record of your configuration
and hardware specifications.

They both fed me wrong answers at times. Google likes to pair it with a line like
"You're completely right, I did...". Having to iterate three or more times to get it to
finally provide the actual current and correct information was far more common than
I would prefer.

## Results

I am weary, and the struggle was far longer than I anticipated, but the result is
spectacular.

My new desktop is very responsive. Memory use is sitting at 6.8 GB with Codium, Chrome, Nautilus
and three Alacritty windows open.

The infinite scrollbar workspace idea is phenomenal. NixOS opens up my most-used software on the
desktops I designated as I log into the desktop. I went with a 3x grid setup, with Alacritty
taking up three slots on workspace 1 - each window taking exactly half the screen real estate.
Chrome and VS Code sit side-by-side at full screen in the middle, on workspace 2. Nautilus leaps
into life on workspace 3 when I launch it. Everything else just launches on the workspace I
am currently using.

This places my development environment front and centre. A quick keypress and I've switched to
the browser. Pressing <CTRL> Up / Down takes me to my terminals, or the file management tools.
The setup is intuitive, and reduces keystrokes. I never have to guess where my tools are or
drag overlapping windows around the screen, or <ALT> Tab through a list of 10 windows to reach
the one I want, only to discover it is shadowing a window I also need to complete my task.

The whole thing looks beautiful. It's easy to switch between a generous selection of wallpapers
to suit my mood. Everything I need for daily work is right there.

Bonus round:

- a clipboard widget that stores all of the cut and copy operations
- a screen capture widget
- a network widget for switching VPNs on and off
- a unified theme, Catppuccin, for my desktop, Codium, and Alacritty

I'm finally home.
