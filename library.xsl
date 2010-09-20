<?xml version="1.0" ?>
<stylesheet version="1.0"
  xmlns="http://www.w3.org/1999/XSL/Transform"
  xmlns:h="http://www.w3.org/1999/xhtml">

  <variable select="''" name="ns.empty" />
  <variable select="'http://www.w3.org/XML/1998/namespace'" name="ns.xml" />
  <variable select="'http://www.w3.org/2000/xmlns/'" name="ns.xmlns" />
  <variable select="'http://www.w3.org/1999/XSL/Transform'" name="ns.xslt" />
  <variable select="'http://www.w3.org/1999/xhtml'" name="ns.xhtml" />
  <variable select="'http://www.w3.org/2000/svg'" name="ns.svg" />
  <variable select="'http://www.w3.org/1998/Math/MathML'" name="ns.mathml" />
  <variable select="'http://www.w3.org/2005/SMIL21/Language'" name="ns.smil" />
  <variable select="'http://www.w3.org/1999/XSL/Format'" name="ns.fo" />
  <variable select="'http://www.w3.org/1999/xlink'" name="ns.xlink" />
  <variable select="'http://www.w3.org/2001/XMLSchema'" name="ns.xsd" />
  <variable select="'http://www.w3.org/2001/XMLSchema-instance'" name="ns.xsd-inst" />
  <variable select="'http://www.w3.org/2001/xforms'" name="ns.xforms" />

  <!-- def format-text -->
  <template name="format-text">
    <param name="text" select="." />
    <param name="indent" />
    <choose>
      <when test="contains($text, '&#xA;')">
        <value-of select="normalize-space(substring-before($text, '&#xA;'))" />
        <text>&#xA;</text>
        <value-of select="$indent" />
        <call-template name="format-text">
          <with-param name="text" select="substring-after($text, '&#xA;')" />
          <with-param name="indent" select="$indent " />
        </call-template>
      </when>
      <otherwise>
        <value-of select="normalize-space($text)" />
      </otherwise>
    </choose>
  </template>

  <!-- def quote -->
  <template name="quote">
    <param name="text" />
    <call-template name="replace">
      <with-param name="text">
        <call-template name="replace">
          <with-param name="text">
            <call-template name="replace">
              <with-param name="text">
                <call-template name="replace">
                  <with-param name="text">
                    <call-template name="replace">
                      <with-param name="text">
                        <value-of select="$text" />
                      </with-param>
                      <with-param name="from" select="'&amp;'" />
                      <with-param name="to" select="'&amp;amp;'" />
                    </call-template>
                  </with-param>
                  <with-param name="from" select='"&apos;"' />
                  <with-param name="to" select="'&amp;apos;'" />
                </call-template>
              </with-param>
              <with-param name="from" select="'&quot;'" />
              <with-param name="to" select="'&amp;quot;'" />
            </call-template>
          </with-param>
          <with-param name="from" select="'&gt;'" />
          <with-param name="to" select="'&amp;gt;'" />
        </call-template>
      </with-param>
      <with-param name="from" select="'&lt;'" />
      <with-param name="to" select="'&amp;lt;'" />
    </call-template>
  </template>

  <!-- def replace -->
  <template name="replace">
    <param name="text" />
    <param name="from" />
    <param name="to" />
    <choose>
      <when test="not($from)">
        <value-of select="$text" />
      </when>
      <when test="contains($text, $from)">
        <value-of select="substring-before($text, $from)" />
        <value-of select="$to" />
        <call-template name="replace">
          <with-param name="text" select="substring-after($text, $from)" />
          <with-param name="from" select="$from" />
          <with-param name="to" select="$to" />
        </call-template>
      </when>
      <otherwise>
        <value-of select="$text" />
      </otherwise>
    </choose>
  </template>

  <!-- def parse_attval -->
  <template name="parse-attval">
    <param name="att" select="." />
    <choose>
      <when test="(namespace-uri($att/..) = $ns.xml   and ( local-name($att) = 'base' )) or
                  (namespace-uri($att/..) = $ns.xhtml and ( local-name($att) = 'src' or local-name($att) = 'href' )) or
                  (namespace-uri($att/..) = $ns.svg   and ( local-name($att) = 'src' )) or
                  (namespace-uri($att/..) = $ns.xslt  and ( local-name($att) = 'href' )) or
                  (namespace-uri($att/..) = $ns.smil  and ( local-name($att) = 'src' or local-name($att) = 'href' )) or
                  (namespace-uri($att) = $ns.xlink and ( local-name($att) = 'href' or local-name($att) = 'role' )) or
                  contains(substring($att, 1, 7), 'http://') or
                  contains(substring($att, 1, 8), 'https://') or
                  contains(substring($att, 1, 7), 'file://') or
                  contains(substring($att, 1, 7), 'mailto:') or
                  contains(substring($att, 1, 6), 'ftp://') or
                  contains(substring($att, 1, 7), 'ftps://') or
                  contains(substring($att, 1, 5), 'news:') or
                  contains(substring($att, 1, 4), 'urn:') or
                  contains(substring($att, 1, 5), 'ldap:') or
                  contains(substring($att, 1, 5), 'data:')">
        <h:a>
          <attribute name="href">
            <value-of select="$att" />
          </attribute>
          <call-template name="quote">
            <with-param name="text" select="$att" />
          </call-template>
        </h:a>
      </when>
      <otherwise>
        <call-template name="quote">
          <with-param name="text" select="$att" />
        </call-template>
      </otherwise>
    </choose>
  </template>

  <!-- def detect-lang -->
  <template name="detect-lang">
    <param name="node" select="." />
    <if test="namespace-uri($node) = $highlight-namespace">
      <text>highlight </text>
    </if>
    <choose>
      <when test="namespace-uri($node) = $ns.empty">
        <text>empty-ns</text>
      </when>
      <when test="namespace-uri($node) = $ns.xml">
        <text>xml</text>
      </when>
      <when test="namespace-uri($node) = $ns.xmlns">
        <text>xmlns</text>
      </when>
      <when test="namespace-uri($node) = $ns.xhtml">
        <text>xhtml</text>
      </when>
      <when test="namespace-uri($node) = $ns.svg">
        <text>svg</text>
      </when>
      <when test="namespace-uri($node) = $ns.xlink">
        <text>xlink</text>
      </when>
      <when test="namespace-uri($node) = $ns.xslt">
        <text>xslt</text>
      </when>
      <when test="namespace-uri($node) = $ns.fo">
        <text>fo</text>
      </when>
      <when test="namespace-uri($node) = $ns.mathml">
        <text>mathml</text>
      </when>
      <when test="namespace-uri($node) = $ns.xsd">
        <text>xsd</text>
      </when>
      <when test="namespace-uri($node) = $ns.xsd-inst">
        <text>xsd-inst</text>
      </when>
      <when test="namespace-uri($node) = $ns.smil">
        <text>smil</text>
      </when>
      <when test="namespace-uri($node) = $ns.xforms">
        <text>xforms</text>
      </when>
      <otherwise />
    </choose>
  </template>

</stylesheet>
