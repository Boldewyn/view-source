<?xml version="1.0" ?>
<t:stylesheet version="1.0"
  xmlns:t="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <!-- Elements (formatted) -->
  <t:template match="*" mode="formatted">
    <t:param name="indent" />
    <t:variable name="lang">
      <t:call-template name="detect-lang" />
    </t:variable>
    <t:value-of select="$indent" />
    <t:choose>
      <t:when test="node()">
        <span class="{$lang} element">
          <span class="tag start">
            <t:text>&lt;</t:text>
            <t:call-template name="print-name" />
            <t:for-each select="@*">
              <t:apply-templates select="." mode="formatted" />
            </t:for-each>
            <t:text>&gt;</t:text>
          </span>
          <t:text>&#x0A;</t:text>
          <t:apply-templates mode="formatted">
            <t:with-param name="indent" select="concat($indent, $base-indent)" />
          </t:apply-templates>
          <t:value-of select="$indent" />
          <span class="tag end">
            <t:text>&lt;/</t:text>
            <t:value-of select="name(.)"/>
            <t:text>&gt;</t:text>
          </span>
        </span>
      </t:when>
      <t:otherwise>
        <span class="{$lang} element empty">
          <span class="tag empty">
            <t:text>&lt;</t:text>
            <t:call-template name="print-name" />
            <t:for-each select="@*">
              <t:apply-templates select="." mode="formatted" />
            </t:for-each>
            <t:text> /&gt;</t:text>
          </span>
        </span>
      </t:otherwise>
    </t:choose>
    <t:text>&#xA;</t:text>
  </t:template>

  <!-- Attributes (formatted) -->
  <t:template match="@*" mode="formatted">
    <t:variable name="lang">
      <t:call-template name="detect-lang" />
    </t:variable>
    <t:text> </t:text>
    <span class="{$lang} attribute">
      <t:call-template name="print-name" />
      <t:text>="</t:text>
      <span class="attribute-value">
        <t:call-template name="parse-attval" />
      </span>
      <t:text>"</t:text>
    </span>
  </t:template>

  <!-- Processing Instructions (formatted) -->
  <t:template match="processing-instruction()" mode="formatted">
    <t:param name="indent" />
    <t:value-of select="$indent" />
    <span class="processing-instruction">
      <t:text>&lt;?</t:text>
      <t:value-of select="name(.)" />
      <t:text> </t:text>
      <t:call-template name="format-text">
        <t:with-param name="text" select="." />
        <t:with-param name="indent" select="$indent" />
      </t:call-template>
      <t:text>?&gt;</t:text>
    </span>
    <t:text>&#xA;</t:text>
  </t:template>

  <!-- Comments (formatted) -->
  <t:template match="comment()" mode="formatted">
    <t:param name="indent" />
    <t:value-of select="$indent" />
    <span class="comment">
      <t:text>&lt;!--</t:text>
      <t:call-template name="format-text">
        <t:with-param name="text" select="." />
        <t:with-param name="indent" select="$indent" />
      </t:call-template>
      <t:text>--></t:text>
    </span>
    <t:text>&#xA;</t:text>
  </t:template>

  <!-- Text (formatted) -->
  <t:template match="text()" mode="formatted">
    <t:param name="indent" />
    <t:if test="normalize-space()">
      <t:value-of select="$indent" />
      <span class="text">
        <t:call-template name="format-text">
          <t:with-param name="text" select="." />
          <t:with-param name="indent" select="$indent" />
        </t:call-template>
      </span>
      <t:text>&#xA;</t:text>
    </t:if>
  </t:template>

</t:stylesheet>
