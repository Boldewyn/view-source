<?xml version="1.0" ?>
<stylesheet version="1.0"
  xmlns="http://www.w3.org/1999/XSL/Transform"
  xmlns:h="http://www.w3.org/1999/xhtml">

  <!-- Elements (formatted) -->
  <template match="*" mode="formatted">
    <param name="indent" />
    <variable name="lang">
      <call-template name="detect-lang" />
    </variable>
    <value-of select="$indent" />
    <choose>
      <when test="node()">
        <h:span class="{$lang} element">
          <h:span class="tag start">
            <text>&lt;</text>
            <value-of select="name(.)" />
            <for-each select="@*">
              <apply-templates select="." mode="formatted" />
            </for-each>
            <text>&gt;</text>
          </h:span>
          <text>&#x0A;</text>
          <apply-templates mode="formatted">
            <with-param name="indent" select="concat($indent, $base-indent)" />
          </apply-templates>
          <value-of select="$indent" />
          <h:span class="tag end">
            <text>&lt;/</text>
            <value-of select="name(.)"/>
            <text>&gt;</text>
          </h:span>
        </h:span>
      </when>
      <otherwise>
        <h:span class="{$lang} element empty">
          <h:span class="tag empty">
            <text>&lt;</text>
            <value-of select="name(.)" />
            <for-each select="@*">
              <apply-templates select="." mode="formatted" />
            </for-each>
            <text> /&gt;</text>
          </h:span>
        </h:span>
      </otherwise>
    </choose>
    <text>&#xA;</text>
  </template>

  <!-- Attributes (formatted) -->
  <template match="@*" mode="formatted">
    <variable name="lang">
      <call-template name="detect-lang" />
    </variable>
    <text> </text>
    <h:span class="{$lang} attribute">
      <value-of select="name()" />
      <text>="</text>
      <h:span class="attribute-value">
        <call-template name="parse-attval" />
      </h:span>
      <text>"</text>
    </h:span>
  </template>

  <!-- Processing Instructions (formatted) -->
  <template match="processing-instruction()" mode="formatted">
    <param name="indent" />
    <value-of select="$indent" />
    <h:span class="processing-instruction">
      <text>&lt;?</text>
      <value-of select="name(.)" />
      <text> </text>
      <call-template name="format-text">
        <with-param name="text" select="." />
        <with-param name="indent" select="$indent" />
      </call-template>
      <text>?&gt;</text>
    </h:span>
    <text>&#xA;</text>
  </template>

  <!-- Comments (formatted) -->
  <template match="comment()" mode="formatted">
    <param name="indent" />
    <value-of select="$indent" />
    <h:span class="comment">
      <text>&lt;!--</text>
      <call-template name="format-text">
        <with-param name="text" select="." />
        <with-param name="indent" select="$indent" />
      </call-template>
      <text>--></text>
    </h:span>
    <text>&#xA;</text>
  </template>

  <!-- Text (formatted) -->
  <template match="text()" mode="formatted">
    <param name="indent" />
    <if test="normalize-space()">
      <value-of select="$indent" />
      <h:span class="text">
        <call-template name="format-text">
          <with-param name="text" select="." />
          <with-param name="indent" select="$indent" />
        </call-template>
      </h:span>
      <text>&#xA;</text>
    </if>
  </template>

</stylesheet>
