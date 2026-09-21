# Working preferences

## Editing config

Make the change and nothing more. Put the reasoning in the chat reply, not in
the file. Comment only mechanics that are genuinely surprising without it — not
self-evident entries in a list.

Never hardcode absolute paths. Use an already-exported variable (`$HOME`,
`$HOMEBREW_PREFIX`, `$XDG_CONFIG_HOME`) instead. Avoid command substitution in
shell startup files — it costs a subprocess on every shell. Guard optional
sources so they degrade quietly when the target is missing.

## Dependencies

Declare a new dependency in the project's manifest, then install from it. Never
install ad-hoc: it works now and disappears on the next machine.

When a tool ships an official plugin, install the plugin rather than pasting its
logic inline. Write custom config only for what the plugin leaves to the user.

## Git

Don't run `git add`, `git commit` or `git push` unless I ask. Leave the working
tree dirty and tell me what changed — I stage and commit myself.

## Answering questions

"How do I…" asks about what already exists — the motion, the keymap, the flag,
the command. Answer with that. Don't write a new file or a helper script unless
I ask for one.

Measure instead of guessing. If a claim about speed, size or behaviour is
checkable here, check it and give the number. Say plainly when something is
unverified, and correct a wrong number as soon as you have the right one.

## Environment

macOS on Apple Silicon. zsh, Neovim, tmux, ghostty. Mostly Ruby and Go.
