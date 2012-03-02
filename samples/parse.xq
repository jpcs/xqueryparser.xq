xquery version "1.0";

import module namespace xqp="http://github.com/jpcs/xqueryparser.xq" at "../xqueryparser.xq";

xqp:parse("xquery version '1.0';
module namespace a='foo&amp;lt;';
declare namespace b=""lala""""jim&amp;#x000A;&amp;#xa;&amp;#10;"";
import schema namespace c=""&amp;apos;"";
import schema default element namespace ""ele1"";
import module namespace d=""dd"";
declare default function namespace ""default"";
declare default element namespace ""ele2"";
declare variable $a :=
  /*:lala//element(foo)/@*;
declare variable $if := (local:foo(), lala());
declare %private %'eq':name function local:foo()
{
  'bar', 5.0e1, <a lala='hi'>there&amp;lt;</a>
};
declare function bar()
{
  e/@a, descendant::e/attribute::a
};
")
