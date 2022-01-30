Nice little console project for showing scales on a guitar

For example:

i use linux
to compile the example in vala

```
valac --pkg posix --pkg gee-0.8 scales.vala FileReader.vala -X -w
```

./scales A Dorian

then it shows

```
Notes : A,B,C,D,E,F#,G
|024-023-022-021-020-019-018-017-016-015-014-013-012-011-010-009-008-007-006-005-004-003-002-001-000|
|---------------------------------------------------------------------------------------------------|
|-O-|---|-O-|---|-O-|-O-|---|-O-|---|-O-|-O-|---|-O-|---|-O-|---|-O-|-O-|---|-O-|---|-O-|-O-|---|-O-|
|-O-|---|-O-|---|-O-|-O-|---|-O-|---|-O-|---|-O-|-O-|---|-O-|---|-O-|-O-|---|-O-|---|-O-|---|-O-|-O-|
|-O-|-O-|---|-O-|---|-O-|---|-O-|-O-|---|-O-|---|-O-|-O-|---|-O-|---|-O-|---|-O-|-O-|---|-O-|---|-O-|
|-O-|---|-O-|-O-|---|-O-|---|-O-|-O-|---|-O-|---|-O-|---|-O-|-O-|---|-O-|---|-O-|-O-|---|-O-|---|-O-|
|-O-|---|-O-|-O-|---|-O-|---|-O-|---|-O-|-O-|---|-O-|---|-O-|-O-|---|-O-|---|-O-|---|-O-|-O-|---|-O-|
|-O-|---|-O-|---|-O-|-O-|---|-O-|---|-O-|-O-|---|-O-|---|-O-|---|-O-|-O-|---|-O-|---|-O-|-O-|---|-O-|

```

because i'm a left-handed player it shows the highest position first :-)

```
scale.ex is my Elixir-Version
scale.sh and libScale.sh is a Bash-Version
scale.jl is my Julia-Version
```


