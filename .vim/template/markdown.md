# 1st level header

## 2nd level header

### 3rd level header

plain text is treated as paragraph, p element.

### links

[example](http://example.com "tile")

reference-style link

[*1][annotation01]


### unordered lists

these are equivalent expression.

- Red
- Green
- Blue

+ Red
+ Green
+ Blue

* Red
* Green
* Blue

Add indents to wrapped words to break line in list item.
blank line is includable.

*   Lorem ipsum dolor sit amet, consectetuer adipiscing elit.

    Aliquam hendrerit mi posuere lectus. Vestibulum enim wisi,
    viverra nec, fringilla in, laoreet vitae, risus.

Add indents to blockquotes or codes in list item

*   blockquotes in item

    > blockquotes

*   codes in item

        $('.datepicker').datepicker();


### ordered lists

1. Red
2. Green
3. Blue

escape . with \ to avoid ordered listing

2013\.07, it was very hard for me.


### codes

#### code in literals

cache the result of calculation to `$memo`.
to write literal backquote, use double backquote ``.

#### code blocks

indent to write code block.

    var date = $('#date').val(),
        year = (date.split('/'))[0];

    $('#year').val(year);


### blockquotes

> blockquotes
> > nested blockquotes
>
> lists in blockquotes
> 1. first item
> 2. second item
>
> codes in blockquotes
>     <p class="line">To be or not to be, that is the question</p>


### images

![alt text](/images/favicon.ico)


### emphasis

*emphasis with em element*
_emphasis with em element_
**emphasis with strong element**
__emphasis with strong element__

to use literal asterisks and underscores, escape with \

\* is pointer operator
\_ is object for underscore.js


### horizontal rules

*********

* * * * *

---------

- - - - -
