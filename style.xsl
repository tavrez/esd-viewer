<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:template match="/">
			x64:
		<xsl:apply-templates select="MCT/Catalogs/Catalog/PublishedMedia/Files">
			<xsl:with-param name="arch" select="'x64'" />
		</xsl:apply-templates>
			x86:
		<xsl:apply-templates select="MCT/Catalogs/Catalog/PublishedMedia/Files">
			<xsl:with-param name="arch" select="'x86'" />
		</xsl:apply-templates>
			ARM64:
		<xsl:apply-templates select="MCT/Catalogs/Catalog/PublishedMedia/Files">
			<xsl:with-param name="arch" select="'ARM64'" />
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="MCT/Catalogs/Catalog/PublishedMedia/Files">
		<xsl:param name="arch" />
		<table border="1">
			<xsl:attribute name="id">
				<xsl:value-of select="$arch" />
			</xsl:attribute>
			<tr>
				<th class='lang'>Language</th>
				<th class='name'>Name</th>
				<th class='url'>URL</th>
				<th class='hash'>Hash</th>
			</tr>
			<xsl:for-each select="File">
				<xsl:sort select="Architecture" />
				<xsl:sort select="LanguageCode" />
				<xsl:sort select="Edition" order="descending"/>
				<xsl:if test="(Architecture=$arch) and ((Edition='Professional') or (Edition='Enterprise') or (Edition='CoreCountrySpecific'))">
					<tr>
						<td class='lang'>
							<xsl:value-of select="LanguageCode" />
						</td>
						<td class='name'>
							<a target="_blank">
								<xsl:attribute name="href">
									<xsl:value-of select="FilePath" />
								</xsl:attribute>
								<xsl:value-of select="FileName" />
							</a>
						</td>
						<td class='url'>
							<xsl:value-of select="FilePath" />
						</td>
						<td class='hash'>
							<xsl:value-of select="Sha1" />
						</td>
					</tr>
				</xsl:if>
			</xsl:for-each>
		</table>
	</xsl:template>
</xsl:stylesheet>
