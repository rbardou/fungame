# Fungame

Fungame is a library which provides game development tools for OCaml.

Currently, Fungame is based on SDL, but the goal is to be abstract enough
that one could make a Javascript version using `js_of_ocaml` and canvas.
You could simply open either `Fungame_sdl` or `Fungame_js` which would have
the same interface.

Fungame provides a widget library which is independant from how inputs are
obtained and how graphics are handled. You could use it without Fungame.
Module `Fungame_sdl` instantiates the `Widget` functor for SDL images
and provides it events obtained through SDL.

## Compile

To compile and install using ocamlfind, run:

    make install

If you just want to compile, run simply run `make`.
To uninstall, run `make uninstall`.

You can also compile the documentation:

    make doc

This creates a symbolic link, named `doc`, to the index of the documentation.
Open it with a web browser.

## Example

To compile the example (`examples/main.ml`), run:

    make example

Run it with `./example` from the root directory of Fungame.
This example shows a pot-pourri of what Fungame can do.

## License

The Fungame source code is released under the MIT license.
See the `LICENSE` file.

The example uses the Sansation font.
See the `examples/sansation/Sansation_1.31_ReadMe.txt` file.

The example also uses a sample from freewavesamples.com.
See the `examples/samples/README` file.

Finally, the example uses the ugly `bat.img` image, drawn by myself using
Inkscape for another game. It is released under CC BY 4.0
(https://creativecommons.org/licenses/by/4.0/).
I won't cry if you don't follow the attribution clause, it's just that I was
too lazy to find a license which did not had it.

## TODO

- `Fungame_js`
- support other sound formats
- maybe music should be handled differently than regular sounds
