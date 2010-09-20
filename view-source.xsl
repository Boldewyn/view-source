<?xml version="1.0" ?>
<?xslt-param name="format" select="false()" ?>
<?xml-stylesheet type="text/xsl" href="view-source.xsl" filename="view-source.xsl" ?>
<stylesheet version="1.0"
  xmlns="http://www.w3.org/1999/XSL/Transform"
  xmlns:h="http://www.w3.org/1999/xhtml">

  <param name="base-indent" select="'  '" />

  <param name="format" select="true()" />

  <param name="style" select="'minimal'" />

  <param name="add-behaviour" select="true()" />

  <param name="highlight-namespace" select="$ns.empty" />

  <include href="formatted.xsl" />

  <include href="original.xsl" />

  <include href="library.xsl" />

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
        <if test="$add-behaviour">
          <h:script type="text/javascript">
            <value-of select="document('behaviour.js')/js" />
          </h:script>
        </if>
      </h:body>
    </h:html>
  </template>

</stylesheet>
