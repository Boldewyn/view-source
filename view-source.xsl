<?xml version="1.0" ?>
<?xslt-param name="format" select="false()" ?>
<?xml-stylesheet type="text/xsl" href="view-source.xsl" filename="view-source.xsl" ?>
<stylesheet version="1.0"
  xmlns="http://www.w3.org/1999/XSL/Transform"
  xmlns:h="http://www.w3.org/1999/xhtml">

  <param name="base-indent" select="'  '" />

  <param name="format" select="true()" />

  <param name="style" select="'minimal'" />

  <include href="formatted.xsl" />

  <include href="original.xsl" />

  <include href="library.xsl" />

  <variable select="'http://www.w3.org/XML/1998/namespace'" name="ns.xml" />
  <variable select="'http://www.w3.org/2000/xmlns/'" name="ns.xmlns" />
  <variable select="'http://www.w3.org/1999/XSL/Transform'" name="ns.xslt" />
  <variable select="'http://www.w3.org/1999/xhtml'" name="ns.xhtml" />
  <variable select="'http://www.w3.org/2000/svg'" name="ns.svg" />
  <variable select="'http://www.w3.org/1998/Math/MathML'" name="ns.mml" />
  <variable select="'http://www.w3.org/2005/SMIL21/Language'" name="ns.smil" />
  <variable select="'http://www.w3.org/1999/XSL/Format'" name="ns.fo" />
  <variable select="'http://www.w3.org/1999/xlink'" name="ns.xlink" />
  <variable select="'http://www.w3.org/2001/XMLSchema'" name="ns.xsd" />
  <variable select="'http://www.w3.org/2001/XMLSchema-instance'" name="ns.xsd-inst" />
  <variable select="'http://www.w3.org/2001/xforms'" name="ns.xforms" />

  <template match="/">
    <h:html>
      <h:head>
        <h:title>XML Source</h:title>
        <h:style type="text/css">
          <value-of select="document(concat($style, '.css'))/css" />
        </h:style>
      </h:head>
      <h:body>
        <h:pre id="source">
          <choose>
            <when test="$format">
              <apply-templates mode="formatted" />
            </when>
            <otherwise>
              <apply-templates mode="original" />
            </otherwise>
          </choose>
        </h:pre>
      </h:body>
    </h:html>
  </template>

</stylesheet>
