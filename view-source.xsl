<?xml version="1.0" ?>
<?xslt-param name="format" select="false()" ?>
<?xml-stylesheet type="text/xsl" href="view-source.xsl" filename="view-source.xsl" ?>
<t:stylesheet version="1.0"
  xmlns:t="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <t:param name="base-indent" select="'  '" />

  <t:param name="format" select="true()" />

  <t:param name="style" select="'minimal'" />

  <t:param name="add-behaviour" select="true()" />

  <t:param name="highlight-namespace" select="''" />

  <t:param name="filename" />

  <t:variable name="version" select="'0.9'" />

  <t:include href="formatted.xsl" />

  <t:include href="original.xsl" />

  <t:include href="library.xsl" />

  <t:output method="xml" indent="yes"
            omit-xml-declaration="yes"
            doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
            doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
    />

  <!--
    master template: Decide between formatted or original rendering
  -->
  <t:template match="/">
    <html xml:lang="en">
      <head>
        <title>
          XML Source
          <t:if test="$filename">of <t:value-of select="$filename" /></t:if>
        </title>
        <meta name="generator" content="view-source {$version}; http://boldewyn.github.com/view-source" />
        <style type="text/css">
          <t:value-of select="document(concat($style, '.css'))/css" />
        </style>
      </head>
      <body>
        <pre id="source">
          <t:choose>
            <t:when test="$format">
              <t:apply-templates mode="formatted" />
            </t:when>
            <t:otherwise>
              <t:apply-templates mode="original" />
            </t:otherwise>
          </t:choose>
        </pre>
        <t:if test="$add-behaviour">
          <t:call-template name="get-namespace-nodes" />
          <script type="text/javascript">
            <t:value-of select="document('behaviour.js')/js" />
          </script>
        </t:if>
      </body>
    </html>
  </t:template>

</t:stylesheet>
