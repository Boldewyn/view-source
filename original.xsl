<?xml version="1.0" ?>
<stylesheet version="1.0"
  xmlns="http://www.w3.org/1999/XSL/Transform"
  xmlns:h="http://www.w3.org/1999/xhtml">

  <!-- Elements (original) -->
  <template match="*" mode="original">
    <variable name="lang">
      <call-template name="detect-lang" />
    </variable>
    <choose>
      <when test="node()">
        <h:span class="{$lang} element">
          <h:span class="tag start">
            <text>&lt;</text>
            <value-of select="name(.)" />
            <for-each select="@*">
              <apply-templates select="." mode="original" />
            </for-each>
            <text>&gt;</text>
          </h:span>
          <apply-templates mode="original" />
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
              <apply-templates select="." mode="original" />
            </for-each>
            <text> /&gt;</text>
          </h:span>
        </h:span>
      </otherwise>
    </choose>
  </template>

  <!-- Attributes (original) -->
  <template match="@*" mode="original">
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

  <!-- Processing Instructions (original) -->
  <template match="processing-instruction()" mode="original">
    <h:span class="processing-instruction">
      <text>&lt;?</text>
      <value-of select="name(.)" />
      <text> </text>
      <value-of select="." />
      <text>?&gt;</text>
    </h:span>
  </template>

  <!-- Comments (original) -->
  <template match="comment()" mode="original">
    <h:span class="comment">
      <text>&lt;!--</text>
      <call-template name="quote">
        <with-param name="text" select="." />
      </call-template>
      <text>--></text>
    </h:span>
  </template>

  <!-- Text (original) -->
  <template match="text()" mode="original">
    <h:span class="text">
      <call-template name="quote">
        <with-param name="text" select="." />
      </call-template>
    </h:span>
  </template>

</stylesheet>
