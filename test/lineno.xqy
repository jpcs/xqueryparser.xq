xquery version "1.0-ml";
(:
 : Licensed under the Apache License, Version 2.0 (the "License");
 : you may not use this file except in compliance with the License.
 : You may obtain a copy of the License at
 :
 :     http://www.apache.org/licenses/LICENSE-2.0
 :
 : Unless required by applicable law or agreed to in writing, software
 : distributed under the License is distributed on an "AS IS" BASIS,
 : WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 : See the License for the specific language governing permissions and
 : limitations under the License.
 :)

module namespace t = "http://github.com/robwhitby/xray/test";
(:~ Test cases for lineno functionality.
 :
 : @author Michael Blakeley
 :)

import module namespace assert="http://github.com/robwhitby/xray/assertions"
  at "/xray/src/assertions.xqy";

import module namespace xqp="http://github.com/jpcs/xqueryparser.xq"
  at "/xqueryparser.xq";

declare function IGNORE-parse($str as xs:string)
{
  let $tree := xqp:parse($str)
  let $assert :=
    if (fn:not($tree instance of element(ERROR))) then ()
    else fn:error((), 'XQP-ERROR', ($tree, $str))
  return $tree
};

declare function parse()
{
  assert:true(fn:true())
};

declare function simple-main()
{
  let $tree := IGNORE-parse('xquery version "1.0-ml";

declare variable $URI as xs:string external; (: 3 :)

xdmp:estimate( (: 5 :)
  doc($URI)/* (: 6 :)
), (: 7 :)
"foo", (: 8 :)
"nine
ten" (: 10 :)
(: end - 11 :)')
  return (
    assert:equal(
      $tree/Module/VersionDecl/(descendant::TOKEN)[1]/@line/fn:data(.), 1),
    assert:equal(
      $tree/Module/MainModule/Prolog/AnnotatedDecl/
      VarDecl/(descendant::TOKEN)[1]/@line/fn:data(.), 3),
    assert:equal(
      $tree/Module/MainModule/Expr/FunctionCall[
        FunctionQName/@localname eq 'estimate']/(
        descendant::QName)[1]/@line/fn:data(.),
      5),
    assert:equal(
      $tree/Module/MainModule/Expr/FunctionCall[
        FunctionQName/@localname eq 'estimate']/
      ArgumentList/RelativePathExpr/FunctionCall[
        FunctionQName/@localname eq 'doc']/(
        descendant::TOKEN)[1]/@line/fn:data(.), 6),
    assert:equal(
      $tree/Module/MainModule/Expr/StringLiteral[
        @value eq 'foo']/@line/fn:data(.), 8),
    assert:equal(
      $tree/Module/MainModule/Expr/StringLiteral[
        @value eq 'nine&#10;ten']/@line/fn:data(.), 9))
};

declare function main-with-all-literal-types()
{
  let $tree := IGNORE-parse('xquery version "1.0-ml";
import module "test" at
"test.xqy";
count((
5,
6.0,
7e0,
"eight
nine"))')
  return (
    assert:equal($tree//URILiteral[ @value="test.xqy" ]/@line/fn:data(.), 3),
    assert:equal($tree//IntegerLiteral[ .="5" ]/@line/fn:data(.), 5),
    assert:equal($tree//DecimalLiteral[ .="6.0" ]/@line/fn:data(.), 6),
    assert:equal($tree//DoubleLiteral[ .="7e0" ]/@line/fn:data(.), 7),
    assert:equal(
      $tree//StringLiteral[ @value="eight&#10;nine" ]/@line/fn:data(.), 8),
    ())
};

(: test/lineno.xqy :)
