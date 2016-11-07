\begingroup
\obeyspaces\obeylines\global\let^^M=\jsR%
\catcode`\"=12%
\gdef\dljsexerquiziii{%
/*
        Document Level JavaScript
        AcroTeX eDucation Bundle
        D. P. Story copyright 2000-\the\year
*/
var exerquizLoaded = true;
this.disclosed = true;
}%
\gdef\dljsexerquiziv{%
var ok2Continue = true;
var ProcessIt = true;
var retn;
var Score=0;
var ptScore=0;
var pcScore=0;
var quizGrade="C";
var e = Math.E;
var pi = Math.PI;
var aQuizControl = new Array();
var RightWrong=new Array();
var ProbValue = new Array();
var ProbDist = new Array();
var ProbType = new Array();
var Responses=new Array();
var appAlerts = new Object;
var JSfBuiltIn = new Array
    ( "abs","acos","asin","atan","ceil","cos","exp",
      "log","max","min","pow","random","round","sin",
      "sqrt","tan");
var JSfCustom = new Array
    ( "arctan", "logc", "arcsin", "arccos", "ln","sec",
      "csc","cot","C","P","fact","pi");
var JSf = new Array();
JSf = JSf.concat(JSfBuiltIn, JSfCustom);
var JSc = new Array("PI","E")
function ln(x) { return Math.log(x); }
function sec(x) { return 1/Math.cos(x); }
function csc(x) { return 1/Math.sin(x);}
function cot(x) { return Math.cos(x)/Math.sin(x); }
function arctan(x) { return Math.atan(x); }
function arcsin(x) { return Math.asin(x); }
function arccos(x) { return Math.acos(x); }
function logc(x) { return Math.LOG10E * Math.log(x); }
function C(x,y) {return ch(x,y);}
function P(x,y) {return perm(x,y);}
var aGroup = new Array
    ( ["\(","\)",\eqParens],
      ["[","]",\eqBrackets],
      ["{","}",\eqBraces]
    );
}%
\gdef\dljsexerquizv{%
function CkBalP(UserInput,lDelimiter,rDelimiter)
{
    var Lcount=0, Rcount=0;
    for (var k=0; k < UserInput.length; k++)
    {
        if (UserInput.charAt(k) == lDelimiter) Lcount++;
        else if (UserInput.charAt(k) == rDelimiter) Rcount++;
    }
    return (Lcount==Rcount);
}
function CkBalVert(UserInput)
{
    var Lcount=0;
    for (var k=0; k < UserInput.length; k++)
        if (UserInput.charAt(k)=="|") Lcount++;
    return (Lcount \% 2 == 0);
}
function Ckfuncs(UserInput)
{
    var re, regexp;
    re = /[a-zA-Z]{2,}/g;
    aF = UserInput.match(re);
    if (  aF == null ) return true;
    for (var i=0; i < aF.length; i++)
    {
        for(var j=0; j < JSf.length; j++)
            if ( aF[i].indexOf(JSf[j]) != -1 ) break;
        if (j < JSf.length) continue;
        for(var j=0; j < JSc.length; j++)
            if ( aF[i].indexOf(JSc[j]) != -1 ) break;
        if(j==JSc.length)
        {
            app.alert(\eqerrBadMathFunc,3);
            return false;
        }
    }
    return true;
}
function DisplayAnswer(fieldname,theanswer)
{
    ProcessIt = false;
    try {
    this.getField(fieldname).value=(theanswer);
    this.getField(fieldname).strokeColor=\eqDefaultColor;
    } catch(e) {}
    ProcessIt = true;
}
function FindBalP(UserInput,Poff,Forward)
{
    var depth;
    if (Forward)
    {
        for (depth=-1, j=Poff+1; depth !=0; j++)
        {
            if (UserInput.charAt(j)=="\(") depth--;
            else if (UserInput.charAt(j)=="\)") depth++;
        }
        j--
    }
    else
    {
        for (depth=-1, j=Poff-1; depth !=0; j--)
        {
            if (UserInput.charAt(j)=="\)") depth--;
            else if (UserInput.charAt(j)=="\(") depth++;
        }
        j++
    }
    return j;
}
function stripWhiteSpace (UserInput)
{
    UserInput = UserInput.replace(/\s/g,"");
    if(UserInput==null || UserInput.length==0)
    {
        ok2Continue = false;
        return false;
    } else return UserInput;
}
function addMathObject(UserInput)
{
    for ( var i=0; i < JSfBuiltIn.length; i++) {
        var re = new RegExp("\\b("+JSfBuiltIn[i]+")\\b","g");
        UserInput = UserInput.replace(re,"Math.$1");
    }
    re = /\b(PI)\b/g;
    UserInput = UserInput.replace(re,"Math.$1");
    return UserInput;
}
function ParseInput(UserInput)
{
    var re;
    UserInput = stripWhiteSpace (UserInput);
    if (!ok2Continue) return null;
    for(var i=0; i< aGroup.length; i++)
    {
        if(!CkBalP(UserInput, aGroup[i][0], aGroup[i][1]))
        {
            app.alert(\eqerrDelimNotBal,3);
            ok2Continue = false;
            return false;
        }
    }
    UserInput = UserInput.replace(/\[|\{/g, "\(");
    UserInput = UserInput.replace(/\]|\}/g, "\)");
    if (!CkBalVert(UserInput))
    {
        app.alert(\eqerrABS,3);
        ok2Continue = false;
        return false;
    }
    if (typeof(Ck4Exponents) == "undefined") if(!Ckfuncs(UserInput)) return false;
    if (typeof(Ck4Exponents) != "undefined") UserInput = Ck4Exponents(UserInput);
    if (typeof(Ck4Products) != "undefined" ) UserInput = Ck4Products(UserInput);
    ok2Continue = true;
    re = /\b(log)\b/g;
    UserInput = UserInput.replace(re, "logc");
    while (/\|/.test(UserInput)&&(ok2Continue))
    {
        re = /(\|)([^\|]*)(\|)([-\+\/\*\^\)\|])/;
        if (re.test(UserInput))
            if (re.exec(UserInput)[4] == '^')
                UserInput = UserInput.replace(re, "(abs($2))$4");
            else
                UserInput = UserInput.replace(re, "abs($2)$4");
        else
        {
            re = /(\|)([^\|]*)(\|$)/;
            if (re.test(UserInput))
                UserInput = UserInput.replace(re, "abs($2)");
        }
    }
    while (/\^/.test(UserInput)&&(ok2Continue))
    {
        if (/\)\^\(/.test(UserInput))
        {
            aP = /\)\^\(/.exec(UserInput);
            LeftP=FindBalP(UserInput,aP.index,0); // backward search
            RightP=FindBalP(UserInput,aP.index+2,1); // forward search
            re = new RegExp("\\((.{"+eval(aP.index-LeftP-1)+"})\\)\\^\\((.{"+eval(RightP-aP.index-3)+"})\\)");
            if (re.test(UserInput)) UserInput=UserInput.replace(re,"pow($1,$2)");
            else ok2Continue=false;
        }
        else if (/\)\^/.test(UserInput))
        {
            aP =/\)\^/.exec(UserInput);
            LeftP=FindBalP(UserInput,aP.index,0); // backward search
            re = new RegExp("\\((.{"+eval(aP.index-LeftP-1)+"})\\)\\^([a-zA-Z]|[\+-]?\\d+\\.?\\d*|[\+-]?\\d*\\.?\\d+)");
            if (re.test(UserInput)) UserInput=UserInput.replace(re,"pow($1,$2)");
            else ok2Continue=false;
        }
        else if (/\^\(/.test(UserInput))
        {
            aP = /\^\(/.exec(UserInput);
            RightP=FindBalP(UserInput,aP.index+1,1); // forward search
            re = new RegExp("([a-zA-Z]|\\d*\\.?\\d*)\\^\\((.{"+eval(RightP-aP.index-2)+"})\\)");
            if (re.test(UserInput)) UserInput=UserInput.replace(re,"pow($1,$2)");
            else ok2Continue=false;
        }
        else if (/\^/.test(UserInput))
        {
            re=/([a-zA-Z]|\d*\.?\d*)\^([a-zA-Z]|[\+-]?\d+\.?\d*|[\+-]?\d*\.?\d+)/;
            if (re.test(UserInput)) UserInput=UserInput.replace(re,"pow($1,$2)");
            else ok2Continue=false;
        }
    }
    if (!ok2Continue)
    {
        app.alert(\eqerrBadExp,3);
\db     console.println("Bad UserInput: " + UserInput);\db%
        return false;
    }
    else {
        UserInput=addMathObject(UserInput);
        return UserInput;
    }
}
function TypeParameters(v)
{
    var aV;
    aV = ( (v.indexOf(":") == -1) && (v.indexOf(",") == -1) ) ? v.split("") : v.split(",");
    for ( var i=0; i < aV.length; i++)
        if ( aV[i].indexOf(":") == -1 )
            aV[i] = "r:"+aV[i];
    return aV.join(",")
}
function ProcResp(flag,CorrAns,n,epsilon,a,indepVar,oComp)
{
    if (!ProcessIt) return null;
    var fieldname = event.target.name;
    var UserAns = event.value;
    var success = _ProcResp(flag,CorrAns,UserAns,n,epsilon,a,indepVar,oComp);
    if ( success == -1 ) return null;
    if ( success == null ) { return syntaxError(), null; }
    return notifyField(success, flag, fieldname);
}
function _ProcResp(flag,CorrAns,UserAns,n,epsilon,a,indepVar,oComp) // changed name of var comp -> oComp
{
    ok2Continue = true;
    CorrAns = ParseInput(CorrAns);
\db console.println("ParseInput: CorrAns = " + CorrAns);\db%
    if (!ok2Continue) {
        app.alert("Syntax error in author's answer! Check console.", 3);
\db     console.println("Syntax Error: " + CorrAns);\db%
        return null;
    }
    var comp = ( typeof oComp == "object" ) ?
       (typeof oComp.comp == "undefined" ) ? diffCompare : oComp.comp : oComp;
    if ( typeof oComp == "object" && typeof oComp.priorParse != "undefined" )
    {
        if ( typeof oComp.priorParse == "object" )
        {
            for ( var i=0; i < oComp.priorParse.length; i++)
            {
                var retn = oComp.priorParse[i](UserAns);
                if ( retn == null ) return -1; // -1 signals an alert has already been made, silent from here
            }
        } else {
            var retn = oComp.priorParse(UserAns);
            if ( retn == null ) return -1;
        }
    }
    UserAns = ParseInput(UserAns);
    indepVar = TypeParameters(indepVar);
    if (!ok2Continue) return null;
    var success=randomPointCompare (n,a,indepVar,epsilon,CorrAns,UserAns,comp);
    return success;
}
function randomPointCompare (n,a,indepVar,epsilon,CorrAns,userAns,comp)
{
    var error, i, j, k;
    var aXY = new Array();
    a = a.replace(/[\[\]\s]/g, "");
    var aIntervals = a.split("&");
    for (k=0; k < aIntervals.length; k++)
    {
        var aInterval = aIntervals[k].split("x");
        nI = aInterval.length;
        with (Math) {
            for (j=0; j < n; j++)
            {
                for (i=0; i < nI; i++)
                {
                    var endpoints = aInterval[i].split(",");
                    aXY[i] = eval(endpoints[0])-0+(eval(endpoints[1])-eval(endpoints[0]))*random();
                }
                var cXY = aXY.toString();
                error = comp(a,cXY,indepVar,CorrAns,userAns);
                if (error == null) return null;
                if ( (error == -1) || (error > epsilon) ) {j=-1; break;}
            }
        }
        if (j!=n) return false;
    }
    return true;
}
function diffCompare(_a,_c,_v,_F,_G) {
    var aXY = _c.split(",");
    var _V = _v.split(",");  // e.g. _V[0] = "i:x"
    var _n = aXY.length;
    for (var _i=0; _i < _n; _i++)
    {
            if (_V[_i].charAt(0) == "r" )
                eval ( "var "+ _V[_i].charAt(2) + " = " + aXY[_i] + ";");
            else // assume type "i"
                eval ( "var "+ _V[_i].charAt(2) + " = " + ceil(aXY[_i]) + ";");
    }
    _F = eval(_F);
    if ( app.viewerVersion >= 5)
    {
        var rtnCode = 0;
        eval("try { if(isNaN(_G = eval(_G))) rtnCode=-1; } catch (e) { rtnCode=1; }");
        switch(rtnCode)
        {
            case  0: break;
            case  1: return null;
            case -1: return -1;
        }
    }
    else
        if(isNaN(_G = eval(_G))) return -1;
    return Math.abs ( _F - _G );
}
function reldiffCompare(_a,_c,_v,_F,_G) {
    var aXY = _c.split(",");
    var n = aXY.length
    for (var i=0; i< n; i++)
            eval ( "var "+_v[i] + " = " + aXY[i] + ";");
    _F = eval(_F);
    if ( app.viewerVersion >= 5)
    {
        var rtnCode = 0;
        eval("try { if(isNaN(_G = eval(_G))) rtnCode=-1; } catch (e) { rtnCode=1; }");
        switch(rtnCode)
        {
            case  0: break;
            case  1: return null;
            case -1: return -1;
        }
    }
    else
        if(isNaN(_G = eval(_G))) return -1;

    return Math.abs ( (_F - _G)/_G );
}
}%
\gdef\dljsexerquizvi{%
function ProcRespTxt() {
    var i, success, authorAnswer, userAnswer = event.value;
    var fieldname=event.target.name;
    var flag = arguments[0];
    var filterMethod = arguments[1];
    var compareMethod = arguments[2];
    if ( !ProcessIt || userAnswer == "" ) return null;
    for (i = 3; i < arguments.length; i++)
        if ( (success = compareTxt(userAnswer, arguments[i], filterMethod, compareMethod)) == true) break;
    return notifyField(success, flag, fieldname);
}
function compareTxt(userAnswer, authorAnswer, filterMethod, compareMethod)
{
    userAnswer = new String(userAnswer).filter(filterMethod)
    switch(compareMethod) {
        case 1:
            var AuthorAnswer;
            var aAuthorAnswer = authorAnswer.split(/\s+/);
            for (var j=0; j < aAuthorAnswer.length; j++) {
                AuthorAnswer = new String(aAuthorAnswer[j]).filter(filterMethod);
                AuthorAnswer = AuthorAnswer.replace(/\./g, "\\.");
                var re = new RegExp(AuthorAnswer, "g");
                if (!re.test(userAnswer)) return false;
            }
            return true;
        default:
            authorAnswer = new String(authorAnswer).filter(filterMethod)
            return (userAnswer == authorAnswer) ? true : false;
    }
}
String.prototype.filter = eqFilter;
function eqFilter(filterMethod) {
    switch (filterMethod) {
        case 0:
            var re = /\W/g;
            return this.replace(re,"").toLowerCase();
        case 1:
            var re = /\s/g;
            return this.replace(re,"").toLowerCase();
        case 2:
            var re = /\s/g;
            return this.replace(re,"");
        default:
            return this;
    }
}
}%
\gdef\dljsexerquizvii{%
function InitMsg(msg) { return (\eqInitQuizMsg) }
function syntaxError() { app.alert(\eqSyntaxErrorUndefVar,3); }
function ProcUserResp(key,userresp,probno,notify)
{
    if ( arguments.length > 4 ) {
        if ( typeof RightWrong[probno] == "undefined" ) {
            RightWrong[probno] = new Array();
            Responses[probno] = new Array();
        }
        RightWrong[probno][arguments[4]] = (!!key) ? 1 : 0;
        Responses[probno][arguments[4]] = userresp;
    } else {
        RightWrong[probno] = (!!key) ? 1 : 0;
        Responses[probno] = userresp;
    }
}
function InitializeQuiz(qtfield,mark)
{
    Score=0;
    retn = null;
    if (!isQuizInitialized(qtfield)&&!isAQuizUnfinished()) return null;
    neutralizeQuizzes();
    ProcessIt = false;
    aQuizControl[qtfield] = 1;
    this.resetForm(["ScoreField." + qtfield,"mc."+qtfield,"obj."+qtfield,
        "Ans."+qtfield,"PointsField."+qtfield,"PercentField."+qtfield,
        "essay."+qtfield,"GradeField."+qtfield, "grpobj."+qtfield,"qMark"]);
    ProcessIt = true;
    var f = this.getField("qMark");
    if ( f != null ) f.display = display.hidden;
    f = this.getField("obj." + qtfield);
    if ( f != null ) f.readonly = false;
    RightWrong=new Array();
    Responses=new Array();
    ProbValue=new Array();
    ProbDist=new Array();
    ProbType=new Array();
    if (mark==1)
    {
        var f = this.getField("mcq." + qtfield);
        if (f != null) {
            f.delay=true;
            f.display=display.hidden;
            this.resetForm([f.name]);
            if (typeof app.formsVersion != "undefined" && app.formsVersion >=4.0)
                f.textColor = \correctColor;
            else
                f.fgColor = \correctColor;
            var a = f.getArray();
            for (var i=0; i<a.length; i++) a[i].style=style.ci;
            f.delay=false;
        }
        f = this.getField("obj." + qtfield);
        if ( f != null )
            f.strokeColor = \eqDefaultColor;
        f = this.getField("grpobj." + qtfield);
        if ( f != null )
            f.strokeColor = \eqDefaultColor;
        f = this.getField("corr." + qtfield);
        if ( f != null )
            f.display = display.hidden;
    }
    return null;
}
function neutralizeQuizzes()
{
    for ( var qtfield in aQuizControl ) aQuizControl[qtfield] = 0;
}
function isAQuizUnfinished()
{
    for ( var qtfield in aQuizControl )
        if ( aQuizControl[qtfield] == 1 )
        {
            app.alert(\eqerrUnfinishQuiz, 3);
            return false;
        }
    return true;
}
function isQuizInitialized(qtfield)
{
    if (typeof (aQuizControl[qtfield]) == "undefined")
    {
        if ( (app.viewerVersion < 5 )&& (app.viewerVersion > 4) && (aQuizControl.length == 0) )
        {
            aQuizControl[0] = -1;
            return true;
        }
        return false;
    }
    else
        return (aQuizControl[qtfield] == 1);
}
function isEndQuizPushed(qtfield)
{
    if (typeof (aQuizControl[qtfield]) == "undefined")
        return false;
    else
        return (aQuizControl[qtfield] == -1);
}
function resetQuiz(qtfield)
{
    aQuizControl[qtfield] = -1;
}
function RecordPointValue(ptvalue,probno)
{
    if (arguments.length > 2) {
        if ( typeof ProbValue[probno] == "undefined" ) {
            ProbValue[probno] = [1,arguments[5],arguments[3],arguments[4]];
            ProbValue[probno][3+arguments[2]] = ptvalue;
        } else ProbValue[probno][3+arguments[2]] = ptvalue;
    }
    else
        ProbValue[probno]=ptvalue;
}
function RecordProblemType(qType,probno)
{
    ProbType[probno]=qType;
}
function GrpRight( a, nProb, qtfield )
{
    var f = this.getField("grpobj."+qtfield+"."+nProb);
    var l = f.getArray().length
    var prod = 1;
    for ( var i=1; i <= l; i++) prod *= !!a[i];
    return prod;

}
function DisplayQuizResults(qtfield,nPointTotal,nQuestions)
{
    Score = 0; ptScore = 0;
    for (var i=1; i < RightWrong.length; i++)
    {
        if (typeof RightWrong[i] == "object") {
            // grouped question
                Score += GrpRight(RightWrong[i], i, qtfield);
                var aWeights = ProbValue[i].slice(2);
                var evalGrpJS = eval(ProbValue[i][1]);
                var evalGrpJSValue = evalGrpJS(this,qtfield,i,RightWrong[i],aWeights);
                ProbDist[i] = evalGrpJSValue;
                ptScore = ptScore + evalGrpJSValue;
        } else {
            if (RightWrong[i]==1) {
                Score++;
                ProbDist[i] = ( typeof ProbValue[i] == "object") ? ProbValue[i][1] : ProbValue[i];
                ptScore += ProbDist[i];
            }
            else {
                ProbDist[i] = ( typeof ProbValue[i] == "object") ? ProbValue[i][2] : 0;
                ptScore += ProbDist[i];
            }
        }
    }
    if (ptScore == nPointTotal) pcScore = 100;
    else pcScore = util.printf("\%.1f", (100 * ptScore) / nPointTotal);
    quizGrade = GetGrade(\eqGradeScale);
    var f = this.getField("ScoreField."+qtfield);
    if ( f != null ) f.value=(\eqQuizTotalMsg);
    f = this.getField("PointsField."+qtfield);
    if ( f != null) f.value=(\eqQuizPointsMsg);
    f = this.getField("PercentField."+qtfield);
    if ( f != null) f.value=(\eqQuizPercentMsg);
    f = this.getField("GradeField."+qtfield);
    if ( f != null) f.value=(\eqQuizGradeMsg);
}
function GetGrade()
{
    var cGrade, aRange;
    if (pcScore >=100) return arguments[0];
    for (var i=0; i<arguments.length/2; i++)
    {
        cGrade = arguments[2*i];
        aRange = arguments[2*i+1];
        if ( (pcScore >= arguments[2*i+1][0]) && (pcScore < arguments[2*i+1][1]))
            return cGrade;
    }
    return null;
}
function ProcessQuestion (key,letterresp,probno,quizno,qtfield,notify,mark,msg)
{
    var silent = ( arguments.length > 8 ) ? true : false;
    if (!isQuizInitialized(qtfield))
    {
        if (!silent) app.alert(InitMsg(msg),3);
        this.resetForm(["mc."+qtfield+"."+probno]);
    }
    else
    {
        ProcUserResp(key,letterresp,probno,notify);
        if (mark==1)
        {
            this.getField("mcq."+qtfield+"."+probno).delay=true;
            this.resetForm(["mcq."+qtfield+"."+probno]);
            var f = this.getField("mcq."+qtfield+"."+probno);
            var a = f.getArray();
            for (var i=0; i < a.length; i++)
                if (a[i].style == style.ch)
                {
                    a[i].style = style.ci;
                    a[i].textColor = \correctColor;
                }
            var qr=this.getField("mcq."+qtfield+"."+probno+"."+quizno);
            if (typeof app.formsVersion != "undefined" && app.formsVersion >=4.0)
                qr.textColor = key ? \checkColor\space : \crossColor;
            else
                qr.fgColor = key ? \checkColor\space : \crossColor;
            qr.style = key ? style.ch : style.cr;
            qr.value="Yes"; // gr.checkThisBox(0);  // ver 5.0
            this.getField("mcq."+qtfield+"."+probno).delay=false;
        }
    }
}
function correctQuiz(qtfield,nQuestions)
{
    var f = this.getField("mcq." + qtfield);
    if ( f != null) f.display = display.visible;
    f = this.getField("obj." + qtfield);
    if ( f != null ) {
        var a = f.getArray();
        for (var i = 0; i < a.length; i++) {
            var probno = a[i].name.replace(/.*\./g,"")
            if ( RightWrong[probno] == 1 )
                a[i].strokeColor = \correctColor;
            else
                a[i].strokeColor = \crossColor;
        }
    }
    f = this.getField("grpobj." + qtfield);
    if ( f != null ) {
        var a = f.getArray();
        for ( var i = 0; i < a.length; i++) {
            var aX = a[i].name.split(".");
            var probno = 1*aX[aX.length-2];
            var grpProbno = 1*aX[aX.length-1];
            if ( ( RightWrong[probno] != undefined ) && ( RightWrong[probno][grpProbno] == 1 ) )
                a[i].strokeColor = \correctColor;
            else
                a[i].strokeColor = \crossColor;
        }
    }
    f = this.getField("Ans." + qtfield);
    if ( f != null ) f.strokeColor = \eqDefaultColor;
    f = this.getField("promptButton." + qtfield)
    if ( f != null ) f.display = display.hidden;
    f = this.getField("corr." + qtfield);
    if ( f != null ) f.display = display.noPrint;
    f = this.getField("qMark");
    if ( f != null )
    {
        for ( var i = 1; i <= nQuestions; i++)
        {
            if ( ProbValue[i] == undefined ) ProbValue[i]=0
            f = this.getField("qMark."+qtfield+"."+(i-1));
            if ( f != null )
            {
                // find the next non-null field
                for ( var j=i; j <= nQuestions; j++)
                {
                    var h = this.getField("qMark."+qtfield+"."+j);
                    if ( h != null ) break;
                }
                var g = f.getArray();
                var qpts = ( ProbDist[i] == undefined ) ? 0 : ProbDist[i];
                g[0].value = qpts + (( qpts == 1 ) ? "pt " : " pts");
            }
        }
        this.getField("qMark").display = display.visible;
    }
}
}%
\gdef\dljsexerquizviii{%
function notifyField(success, flag, fieldname) {
    if (success) {
        if (flag == 0) {
            this.getField(fieldname).strokeColor = \correctColor;
        }
        return true;
    }
    else {
        if (flag == 0) {
            updateTally(fieldname);
            this.getField(fieldname).strokeColor = \wrongColor;
        }
        return false;
    }
    return null;
}
function updateTally(fieldname)
{
    var objre = /^obj\./;
    var grpre = /^grpobj\./;
    if ( grpre.test(fieldname) ) {
        fieldname = fieldname.replace(grpre,"");
        var pos = fieldname.lastIndexOf(".");
        fieldname = fieldname.substring(0,pos);
    } else if ( objre.test(fieldname) ) fieldname = fieldname.replace(objre,"");
    var f = this.getField("tally."+fieldname)
    if ( f != null ) {
        f.value += 1;
        return true;
    } else return false;

}
function noPeek(qtfield,rtnPage)
{
    if ( (typeof (aQuizControl[qtfield]) == "undefined") || (aQuizControl[qtfield] != -1) )
    {
        this.pageNum = rtnPage-1;
        app.alert(\noPeekMsg,3);
    }
}
function OnBlurRespBox (retn)
{
    var respMsg;
    var cTitle = "AcroTeX eDucation Bundle";
    if (retn != null) {
        if ( typeof appAlerts[arguments[1]] == "undefined")
            appAlerts[arguments[1]] = {bAfterValue: false};

        var respMsg = (retn) ? \eqsqrtmsg : \eqsqwgmsg;

        if (event.target == this)
            app.alert({ cMsg: respMsg, nIcon: 3, cTitle: cTitle });
        else {
            if ( ! appAlerts[arguments[1]].bAfterValue )
                app.alert({ cMsg: respMsg, nIcon: 3, cTitle: cTitle,
                oCheckbox: appAlerts[arguments[1]]});
        }
    }
    else {
        var str = event.target.value.toString();
        if (str.replace(/\s/g,"") == "")
            event.target.strokeColor = \eqDefaultColor;
    }
}
function lowThreshold(nQuestions)
{
    return true;
}
function highThreshold(nQuestions)
{
    if (Responses.length <= nQuestions)
        app.alert(\highThresholdMsg,3)
    return (Responses.length > nQuestions);
}
}%
\gdef\dljsexerquizix{%
function groupEval(doc,qtfield,probno,aKey,aWeights)
{
    var totalGrpPts = aWeights[0];
    var totalWeight = aWeights[1];
    var total=0;
    for ( var i=1; i< aKey.length; i++ )
        if (aKey[i] != undefined) total += aKey[i]*aWeights[i+1];
    return total;
}
function WeightedEval(doc,qtfield,probno,aKey,aWeights)
{
    var f = doc.getField("grpobj." + qtfield + "." + probno);
    var nGrpQno = f.getArray().length;
    var totalGrpPts = aWeights[0];
    var totalWeight = aWeights[1];
    var total=0;
    for ( var i=1; i < aKey.length; i++ )
        if (aKey[i] != undefined) total += aKey[i]*aWeights[i+1];
    total /= totalWeight;
    total = Math.floor( total * totalGrpPts );
    return total;
}
}%
\endgroup
\begingroup 
\ccpdftex%
\input{dljscc.def}%
\immediate\pdfobj{ << /S /JavaScript /JS (\dljsexerquiziii) >> }
\xdef\objexerquiziii{\the\pdflastobj\space0 R}
\immediate\pdfobj{ << /S /JavaScript /JS (\dljsexerquiziv) >> }
\xdef\objexerquiziv{\the\pdflastobj\space0 R}
\immediate\pdfobj{ << /S /JavaScript /JS (\dljsexerquizv) >> }
\xdef\objexerquizv{\the\pdflastobj\space0 R}
\immediate\pdfobj{ << /S /JavaScript /JS (\dljsexerquizvi) >> }
\xdef\objexerquizvi{\the\pdflastobj\space0 R}
\immediate\pdfobj{ << /S /JavaScript /JS (\dljsexerquizvii) >> }
\xdef\objexerquizvii{\the\pdflastobj\space0 R}
\immediate\pdfobj{ << /S /JavaScript /JS (\dljsexerquizviii) >> }
\xdef\objexerquizviii{\the\pdflastobj\space0 R}
\immediate\pdfobj{ << /S /JavaScript /JS (\dljsexerquizix) >> }
\xdef\objexerquizix{\the\pdflastobj\space0 R}
\endgroup 
\endinput
