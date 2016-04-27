  <!--
    Copyright (c) 2010-2011 VIVO Harvester Team. For full list of
    contributors, please see the AUTHORS file provided. All rights
    reserved. This program and the accompanying materials are made
    available under the terms of the new BSD license which accompanies
    this distribution, and is available at
    http://www.opensource.org/licenses/bsd-license.html
  -->
  <!-- <?xml version="1.0"?> -->
  <!--
    Header information for the Style Sheet The style sheet requires xmlns
    for each prefix you use in constructing the new elements
  -->
<xsl:stylesheet version="2.0"
    xmlns:xsl = "http://www.w3.org/1999/XSL/Transform"
    xmlns:rdf = "http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs = "http://www.w3.org/2000/01/rdf-schema#"
    xmlns:vivo = "http://vivoweb.org/ontology/core#" 
    xmlns:score = "http://vivoweb.org/ontology/score#"
    xmlns:foaf = "http://xmlns.com/foaf/0.1/"
    xmlns:bibo = "http://purl.org/ontology/bibo/"
    xmlns:obo = "http://purl.obolibrary.org/obo/"
    xmlns:vitro = "http://vitro.mannlib.cornell.edu/ns/vitro/0.7#"
    xmlns:vcard = "http://www.w3.org/2006/vcard/ns#"
    xmlns:geo = "http://aims.fao.org/aos/geopolitical.owl#"
    xmlns:db-vivotest="jdbc:mysql://localhost/caudata/fields/vivotest/"
    xmlns:localVivo = "http://vivo.sample.edu/ontology/"
    xmlns:agrivivo = "http://www.agrivivo.net/ontology/agrivivo#"    
    
  >

  <!-- This will create indenting in xml readers -->
  <xsl:output method="xml" indent="yes" />
  <xsl:variable name="baseURI">http://vivo.example.com/harvest/</xsl:variable>

  <!--
    The main node of the record loaded This serves as the header of the
    RDF file produced
  -->
  <xsl:template match="rdf:RDF">
    <rdf:RDF xmlns:rdf = "http://www.w3.org/1999/02/22-rdf-syntax-ns#"
            xmlns:rdfs = "http://www.w3.org/2000/01/rdf-schema#"
            xmlns:vivo = "http://vivoweb.org/ontology/core#"
            xmlns:score = "http://vivoweb.org/ontology/score#"
            xmlns:foaf = "http://xmlns.com/foaf/0.1/"
            xmlns:bibo = "http://purl.org/ontology/bibo/">
      <xsl:apply-templates select="rdf:Description" />
    </rdf:RDF>
  </xsl:template>

  <!-- Here are the fields: 
NUMBER, ORCID, NAME, SEX, PHOTO, POSITION, DAOSHITYPE, YUANSHI1, YUANSHI2, XUEWEI, XUEKE, ZHUANYE, FANAXIANG, UNIVERSITY, A1, A2, PROJECT, BOOKS, ARTICLE, CURSE, WEBSITE, ADDRESS, PHONE, EMAIL
   -->

  <xsl:template match = "rdf:Description">
    <xsl:variable name = "this" select = "." />
    <xsl:call-template name = "t_People">
      <xsl:with-param name = "this" select = "$this" />
      <xsl:with-param name = "personid" select = "$this/db-vivotest:number" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="t_People"
     
  >
    <xsl:param name = 'personid' />
    <xsl:param name = 'this' />

    <xsl:variable name="orcid" select = "$this/db-vivotest:orcid" />
    <xsl:variable name="name" select="$this/db-vivotest:name"/>
    <xsl:variable name="sex" select="$this/db-vivotest:sex"/>    
    <xsl:variable name="photo" select="$this/db-vivotest:photo" />
    <xsl:variable name="position" select = "$this/db-vivotest:position" />
    <xsl:variable name="daoshitype" select = "$this/db-vivotest:daoshitype" />
    <xsl:variable name="yuanshi1" select = "$this/db-vivotest:yuanshi1" />
    <xsl:variable name="yuanshi2" select = "$this/db-vivotest:yuanshi2" />
    <xsl:variable name="education" select = "$this/db-vivotest:xuewei" /> 
    <xsl:variable name="xueke" select="$this/db-vivotest:xueke"/>
    <xsl:variable name="zhuanye" select="$this/db-vivotest:zhuanye"/>
    <xsl:variable name="fanaxiang" select="$this/db-vivotest:fanaxiang"/>
    <xsl:variable name="university" select="$this/db-vivotest:university"/>
    <xsl:variable name="universityID" select="encode-for-uri($this/db-vivotest:university)"/>
    <xsl:variable name="college" select="$this/db-vivotest:xueyuan"/>
    <xsl:variable name="collegeID" select="encode-for-uri($this/db-vivotest:xueyuan)"/>
    <xsl:variable name="a1" select="$this/db-vivotest:a1"/>
    <xsl:variable name="a2" select="$this/db-vivotest:a2"/>
    <xsl:variable name="project" select="$this/db-vivotest:project"/>
    <xsl:variable name="books" select="$this/db-vivotest:books"/>
    <xsl:variable name="article" select="$this/db-vivotest:article"/>
    <xsl:variable name="curse" select="$this/db-vivotest:curse"/>
    <xsl:variable name="website" select="$this/db-vivotest:website"/>
    <xsl:variable name="address" select="$this/db-vivotest:address"/>
    <xsl:variable name="phone" select="$this/db-vivotest:phone"/>
    <xsl:variable name="email" select="$this/db-vivotest:email"/>

    <xsl:variable name="rolename">
      <xsl:choose>
         <xsl:when test="normalize-space( $this/db-vivotest:position )">
	 <xsl:value-of select="$this/db-vivotest:position" />
	 </xsl:when>
	 <xsl:otherwise>Affiliate</xsl:otherwise>
	 </xsl:choose>
    </xsl:variable>
 
    <xsl:variable name="roleid">
      <xsl:choose>
         <xsl:when test="normalize-space( $this/db-vivotest:position )">
	 <xsl:value-of select="encode-for-uri($this/db-vivotest:position)" />
	 </xsl:when>
	 <xsl:otherwise>Affiliate</xsl:otherwise>
	 </xsl:choose>
    </xsl:variable>

    


  <!-- Here are the fields: 
NUMBER, ORCID, NAME, SEX, PHOTO, POSITION, DAOSHITYPE, YUANSHI1, YUANSHI2, XUEWEI, XUEKE, ZHUANYE, FANAXIANG, UNIVERSITY, A1, A2, PROJECT, BOOKS, ARTICLE, CURSE, WEBSITE, ADDRESS, PHONE, EMAIL
   -->

    <!-- Person -->
    <rdf:Description rdf:about="{$baseURI}person/person{$personid}">

      <localVivo:harvestedBy>CAU Harvester</localVivo:harvestedBy>      
      <rdf:type rdf:resource = "http://xmlns.com/foaf/0.1/Person"/>
      <vitro:mostSpecificType rdf:resource="http://xmlns.com/foaf/0.1/Person"/>
      <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select = "$name" /></rdfs:label>
      <localVivo:personID rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select="$personid" /></localVivo:personID>
      
       
      <score:email><xsl:value-of select= "$email" /></score:email>
      <score:name><xsl:value-of select= "$name" /></score:name>
      
     
      <!--
      <vivo:overview><xsl:value-of select= "$xueke" /> <xsl:value-of select= "$zhuanye" /> <xsl:value-of select= "$fanaxiang" /> </vivo:overview>
      -->
  
      <obo:ARG_2000028 rdf:resource="{$baseURI}vcard/vcardFor{$personid}"/>
      
      <!--
      <xsl:if test="normalize-space( $geolocation )">
         <obo:RO_0001025 rdf:resource="{$geolocation}"/>
         <vivo:hasGeographicLocation rdf:resource="{$geolocation}" />
      </xsl:if>
      -->

      
      <xsl:if test="($universityID !='') and ($roleid!='')" >
      <vivo:relatedBy rdf:resource="{$baseURI}position/positionFor{$universityID }-{$roleid}"/>
      </xsl:if>

      <xsl:if test="($collegeID !='') and ($roleid!='')" >
      <vivo:relatedBy rdf:resource="{$baseURI}position/positionFor{$collegeID }-{$roleid}"/>
      </xsl:if>

      <xsl:if test="normalize-space( $photo )">
         <localVivo:photo><xsl:value-of select="$photo" /></localVivo:photo>
      </xsl:if>
      

    </rdf:Description>
    
    <!-- vcard for person -->
     <rdf:Description rdf:about="{$baseURI}vcard/vcardFor{$personid}"> 
       <vcard:hasName rdf:resource="{$baseURI}vcard/vcardNameFor{$personid}"/>

       <vitro:mostSpecificType rdf:resource="http://www.w3.org/2006/vcard/ns#Individual"/>
       <rdf:type rdf:resource="http://www.w3.org/2006/vcard/ns#Individual"/>
       <rdf:type rdf:resource="http://purl.obolibrary.org/obo/ARG_2000379"/>
       <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string">vCard for: <xsl:value-of select = "$name" /></rdfs:label>
       <vcard:hasEmail rdf:resource="{$baseURI}vcard/vcardEmailFor{$personid}"/>
       <xsl:if test="normalize-space( $website )">
       <vcard:hasUrl rdf:resource="{$baseURI}vcard/urlFor{$personid}"/>
       </xsl:if>

       <xsl:if test="normalize-space( $address )">
       <vcard:hasAddress rdf:resource="{$baseURI}vcard/vcardAddressFor{$personid}"/>
       </xsl:if>

       <xsl:if test="normalize-space( $rolename )">
       <vcard:hasTitle rdf:resource="{$baseURI}vcard/vcardTitleFor{$personid}"/>
       </xsl:if>

       <xsl:if test="normalize-space( $xueke )">
              <xsl:call-template name="hasSubjectArea">
              <xsl:with-param name="list" select="$xueke" />
              </xsl:call-template>        
       </xsl:if>
       <obo:ARG_2000029 rdf:resource="{$baseURI}person/person{$personid}"/>
       
     </rdf:Description>
     
     <!-- vcard name -->
     <rdf:Description rdf:about="{$baseURI}vcard/vcardNameFor{$personid}">
       <rdf:type rdf:resource="http://www.w3.org/2006/vcard/ns#Name"/> 
       <vitro:mostSpecificType rdf:resource="http://www.w3.org/2006/vcard/ns#Name"/>
       <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string">vCard name for: <xsl:value-of select = "$name" /></rdfs:label>
       <vcard:givenName rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select = "$name" /></vcard:givenName>     
       <!--
       <vcard:familyName rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select = "$lastName" /></vcard:familyName>
      -->
     </rdf:Description>
     
     <!-- vcard email -->
     <rdf:Description rdf:about="{$baseURI}vcard/vcardEmailFor{$personid}">
       <rdf:type rdf:resource="http://www.w3.org/2006/vcard/ns#Email"/>
       <rdf:type rdf:resource="http://www.w3.org/2006/vcard/ns#Work"/>
       <vitro:mostSpecificType rdf:resource="http://www.w3.org/2006/vcard/ns#Email"/>
       <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string">vCard email for: <xsl:value-of select = "$name" /></rdfs:label>
       <vcard:email rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select = "$email" /></vcard:email>  
     </rdf:Description>
     
     <!-- vcard title -->
     <xsl:if test="normalize-space( $rolename )">
     <rdf:Description rdf:about="{$baseURI}vcard/vcardTitleFor{$personid}">
       <rdf:type rdf:resource="http://www.w3.org/2006/vcard/ns#Title"/>
       <vitro:mostSpecificType rdf:resource="http://www.w3.org/2006/vcard/ns#Title"/>
       <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string">vCard title for: <xsl:value-of select = "$name" /></rdfs:label>
       <vcard:title rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select = "$rolename" /></vcard:title>  
     </rdf:Description>
     </xsl:if>
     
     <!--  vcard person url -->
     <xsl:if test="normalize-space( $website )">
     <rdf:Description rdf:about="{$baseURI}vcard/urlFor{$personid}"> 
       <rdf:type rdf:resource="http://www.w3.org/2006/vcard/ns#URL"/> 
       <vitro:mostSpecificType rdf:resource="http://www.w3.org/2006/vcard/ns#URL"/>
       <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string">vCard url for: <xsl:value-of select = "$name" /></rdfs:label>
       <vcard:url rdf:datatype="http://www.w3.org/2001/XMLSchema#anyURI"><xsl:value-of select = "$website" /></vcard:url>     
       <rdfs:label>Website</rdfs:label>
       <vivo:rank rdf:datatype="http://www.w3.org/2001/XMLSchema#int">1</vivo:rank>     
     </rdf:Description>
     </xsl:if>
          <!-- vcard address -->
     <rdf:Description rdf:about="{$baseURI}vcard/vcardAddressFor{$personid}">
       <rdf:type rdf:resource="http://www.w3.org/2006/vcard/ns#Geo"/>
       <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string">vCard Address for: <xsl:value-of select = "$name" /></rdfs:label>
       <vitro:mostSpecificType rdf:resource="http://www.w3.org/2006/vcard/ns#Address"/>

       <vcard:streetAddress rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select = "$address" /></vcard:streetAddress>
       <!--      
       <vcard:postalCode rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select = "$zipcode" /></vcard:postalCode>
       <vcard:locality rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select = "$city" /></vcard:locality>

       -->
       

     </rdf:Description> 
     <!-- position in university -->
     <xsl:if test="($universityID !='') and ($roleid!='')" >
     <rdf:Description rdf:about="{$baseURI}position/positionFor{$universityID }-{$roleid}" >
        <rdf:type rdf:resource="http://vivoweb.org/ontology/core#Relationship"/>
        <rdf:type rdf:resource="http://vivoweb.org/ontology/core#Position"/>
        <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select = "$rolename" /></rdfs:label>
        <score:position><xsl:value-of select= "$rolename" /></score:position>
        <score:university><xsl:value-of select = "$university" /></score:university>

        <vivo:relates rdf:resource="{$baseURI}person/person{$personid}" />
        <vivo:relates rdf:resource="{$baseURI}org/{$universityID }" />

     </rdf:Description>
     </xsl:if>

     <!-- position in college  -->
     <xsl:if test="($collegeID !='') and ($roleid!='')" >
     <rdf:Description rdf:about="{$baseURI}position/positionFor{$collegeID }-{$roleid}" >
        <rdf:type rdf:resource="http://vivoweb.org/ontology/core#Relationship"/>
        <rdf:type rdf:resource="http://vivoweb.org/ontology/core#Position"/>
        <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select = "$rolename" /></rdfs:label>
        <score:position><xsl:value-of select= "$rolename" /></score:position>
        <score:college><xsl:value-of select = "$college" /></score:college>

        <vivo:relates rdf:resource="{$baseURI}person/person{$personid}" />
        <vivo:relates rdf:resource="{$baseURI}org/{$collegeID }" />

     </rdf:Description>
     </xsl:if>

     <!--  Organization for University -->
     <xsl:if test="normalize-space( $universityID  )">
     <rdf:Description rdf:about="{$baseURI}org/{$universityID }">
        <localVivo:harvestedBy>CAU Harvester</localVivo:harvestedBy>      
        <rdf:type rdf:resource="http://xmlns.com/foaf/0.1/Organization"/>
        <rdf:type rdf:resource="http://vivoweb.org/ontology/core#University"/>
        <vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#University" />
        <xsl:if test="normalize-space( $roleid )">
        <vivo:relatedBy rdf:resource="{$baseURI}position/positionFor{$universityID }-{$roleid}" />
        </xsl:if>
        <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select = "$university" /></rdfs:label>
        <score:university><xsl:value-of select = "$university" /></score:university>
     </rdf:Description>
     </xsl:if> 

     <!--  Organization for College -->
     <xsl:if test="normalize-space( $collegeID  )">
     <rdf:Description rdf:about="{$baseURI}org/{$collegeID }">
        <localVivo:harvestedBy>CAU Harvester</localVivo:harvestedBy>      
        <rdf:type rdf:resource="http://xmlns.com/foaf/0.1/Organization"/>
        <rdf:type rdf:resource="http://vivoweb.org/ontology/core#College"/>
        <vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#College" />
        <xsl:if test="normalize-space( $roleid )">
        <vivo:relatedBy rdf:resource="{$baseURI}position/positionFor{$collegeID }-{$roleid}" />
        </xsl:if>
        <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select = "$college" /></rdfs:label>
        <score:college><xsl:value-of select = "$college" /></score:college>
     </rdf:Description>
     </xsl:if> 
     
     
     <!-- add class for concepts --> 
     <xsl:if test="normalize-space( $xueke )">
        <xsl:call-template name="concept">
              <xsl:with-param name="list" select="$xueke" />
              <xsl:with-param name="personid" select="$personid" />
        </xsl:call-template>        
     </xsl:if>
  </xsl:template>
  
  <!-- concepts --> 
  <xsl:template name="concept">
  <xsl:param name='list' />
  <xsl:param name='personid' />
  <xsl:if test="contains($list, ',')">
     <xsl:variable name = "term"><xsl:value-of select="substring-before($list, ',')"/></xsl:variable>
     <xsl:variable name = "termEncoded" select="encode-for-uri($term)"/>
     <rdf:Description rdf:about="{$baseURI}concept/{$termEncoded}">
       <rdf:type rdf:resource="http://www.w3.org/2004/02/skos/core#Concept"/> 
       <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select="substring-before($list, ',')"/></rdfs:label>
       <vivo:researchAreaOf rdf:resource="{$baseURI}person/person{$personid}" />
       <vivo:subjectAreaOf rdf:resource="{$baseURI}person/person{$personid}" />
     </rdf:Description>
     
     <xsl:call-template name="concept">
        <xsl:with-param name="list" select="substring-after($list, ', ')"/>
        <xsl:with-param name="personid" select="$personid" />
     </xsl:call-template>
       
  </xsl:if>        
  </xsl:template>
  
  <!-- create vivo:hasResearchArea -->
  <xsl:template name="hasResearchArea">
  <xsl:param name='list' />
  <xsl:param name='personid' />
  <xsl:if test="contains($list, ',')">
     <xsl:variable name = "term"><xsl:value-of select="substring-before($list, ',')"/></xsl:variable>
     <xsl:variable name = "termEncoded" select="encode-for-uri($term)"/> 
     <vivo:hasResearchArea rdf:resource="{$baseURI}concept/{$termEncoded}"/>
     <xsl:call-template name="hasResearchArea">
        <xsl:with-param name="list" select="substring-after($list, ', ')"/>
        <xsl:with-param name="personid" select="$personid" />
     </xsl:call-template>
       
  </xsl:if>        
  </xsl:template>
  
  <!-- create vivo:hasSubjectArea -->
  <xsl:template name="hasSubjectArea">
  <xsl:param name='list' />
  <xsl:param name='personid' />
  <xsl:if test="contains($list, ',')">
     <xsl:variable name = "term"><xsl:value-of select="substring-before($list, ',')"/></xsl:variable>
     <xsl:variable name = "termEncoded" select="encode-for-uri($term)"/> 
     <vivo:hasSubjectArea rdf:resource="{$baseURI}concept/{$termEncoded}"/>
     <xsl:call-template name="hasSubjectArea">
        <xsl:with-param name="list" select="substring-after($list, ', ')"/>
        <xsl:with-param name="personid" select="$personid" />
     </xsl:call-template>
       
  </xsl:if>        
  </xsl:template>
  
  <xsl:template name="expertise">
     <xsl:param name='list' />
     <xsl:if test="contains($list, ',')">          
         <vivo:freetextKeyword><xsl:value-of select="substring-before($list, ',')"/></vivo:freetextKeyword>          
         <xsl:call-template name="expertise">
            <xsl:with-param name="list" select="substring-after($list, ', ')"/>
        </xsl:call-template>
     </xsl:if>        
  </xsl:template>
  
  <xsl:template name="interest">
     <xsl:param name='list' />
     <xsl:if test="contains($list, ',')">          
         <vivo:freetextKeyword><xsl:value-of select="substring-before($list, ',')"/></vivo:freetextKeyword>          
         <xsl:call-template name="interest">
            <xsl:with-param name="list" select="substring-after($list, ', ')"/>
        </xsl:call-template>
     </xsl:if>        
  </xsl:template>
   
  
</xsl:stylesheet>
