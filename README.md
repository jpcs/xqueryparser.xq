# library module: http://github.com/jpcs/xqueryparser.xq
   
# xqueryparser.xq  

An parser for XQuery 3.0 and MarkLogic extensions.
     


Author:  John Snelson    Feb 17, 2012   
Version:  0.1 

## Table of Contents

* Functions: [ parse\#1](#func_ parse_1)


## Functions

### <a name="func_ parse_1"/>  parse\#1
```xquery
 parse($module as xs:string
) as  element()
```
   Parses the XQuery module in the string argument. The module string  is returned marked up in elements, with attributes adding statically  analysed values like unescaped string values, and lexical QNames  resolved to expanded QNames.   


#### Params

* $module as  xs:string: XQuery module passed as a string


#### Returns
*  element(): A marked up copy of the XQuery module, or an error element detailing the parse error encountered.




*Generated by [xquerydoc](https://github.com/xquery/xquerydoc)*
