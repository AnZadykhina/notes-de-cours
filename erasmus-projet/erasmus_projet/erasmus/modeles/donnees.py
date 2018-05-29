from ..app import db



# On crée notre modèle
class Edition(db.Model):
    edition_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    edition_short_title = db.Column(db.Text)
    edition_title_notes = db.Column(db.Text)
    edition_full_title = db.Column(db.Text)
    edition_uniform_title = db.Column(db.Text)
    edition_author_first = db.Column(db.Text, nullable=False)
    edition_author_second = db.Column(db.Text)
    edition_publisher = db.Column(db.Text)
    edition_prefaceur = db.Column(db.Text)
    edition_translator = db.Column(db.Text)
    edition_dateInferred = db.Column(db.Text)
    edition_displayDate = db.Column(db.Text)
    edition_cleanDate = db.Column(db.Text)
    edition_languages = db.Column(db.Text)
    edition_placeInferred = db.Column(db.Text)
    edition_place = db.Column(db.Text)
    edition_place2 = db.Column(db.Text)
    edition_placeClean = db.Column(db.Text)
    edition_country = db.Column(db.Text)
    edition_collator_format = db.Column(db.Text)
    edition_collator_formatNotes = db.Column(db.Text)
    edition_imprint = db.Column(db.Text)
    edition_collator_signatures = db.Column(db.Text)
    edition_collator_PpFf    = db.Column(db.Text)
    edition_collator_pages  = db.Column(db.Text)
    edition_collator_remarks  = db.Column(db.Text)
    edition_collator_colophon  = db.Column(db.Text)
    edition_collator_illustrated   = db.Column(db.Text)
    edition_collator_typographicMaterial  = db.Column(db.Text)
    edition_collator_sheets = db.Column(db.Text)
    edition_collator_typeNotes = db.Column(db.Text)
    edition_collator_stcNotes   = db.Column(db.Text)
    edition_collator_fb = db.Column(db.Text)
    edition_collator_nb = db.Column(db.Text)
    edition_collator_ib  = db.Column(db.Text)
    edition_collator_correct  = db.Column(db.Text)
    edition_collator_locFingerprints = db.Column(db.Text)
    edition_collator_stcnFingerprints = db.Column(db.Text)
    edition_collator_tpt = db.Column(db.Text)
    edition_notes = db.Column(db.Text)
    edition_printer = db.Column(db.Text)
    edition_urlImage = db.Column(db.Text)
    edition_class0 = db.Column(db.Text)
    edition_class1 = db.Column(db.Text)
    edition_class2 = db.Column(db.Text)
    edition_internal = db.Column(db.Text)
    edition_digital = db.Column(db.Text)
    edition_fulltext = db.Column(db.Text)
    edition_tpimage = db.Column(db.Text)
    edition_privelege = db.Column(db.Text)
    edition_dedication = db.Column(db.Text)
    edition_reference = db.Column(db.Text)
    edition_location = db.Column(db.Text)
    edition_citation = db.Column(db.Integer)
    exemplaire = db.relationship("Exemplaire", back_populates="edition", lazy='dynamic')
    edit_author = db.relationship("Edit_author", back_populates="edition")
    reference = db.relationship("Reference", back_populates="edition")
    citation = db.relationship("Citation", back_populates="edition")
    digital = db.relationship("Digital", back_populates="edition")


    def creer_edition(short_title, title_notes, uniform_title, full_title, author_first, author_second, publisher, prefaceur, translator, dateInferred, displayDate, cleanDate, languages, placeInferred, place, placeClean, place2, country, format, formatNotes, imprint, signatures, PpFf, pages, remarks, colophon, illustrated, typographicMaterial, sheets, typeNotes, stcNotes, fb, nb, ib, correct, locFingerprints, stcnFingerprints, tpt, notes, printer, urlImage, class0, class1, internal, class2, digital, fulltext, tpimage, privelege, dedication, reference, location, citation):
        erreurs = []
        if not short_title:
            erreurs.append("Le titre fourni est vide")
        if not author_first:
            erreurs.append("Le nom d'auteur fourni est vide")

        # Si on a au moins une erreur
        if len(erreurs) > 0:
            return False, erreurs

        # On crée un commentaire
        edition = Edition(
            edition_short_title=short_title,
            edition_title_notes=title_notes,
            edition_uniform_title=uniform_title,
            edition_full_title=full_title,
            edition_author_first=author_first,
            edition_author_second=author_second,
            edition_publisher=publisher,
            edition_prefaceur=prefaceur,
            edition_translator=translator,
            edition_dateInferred=dateInferred,
            edition_displayDate=displayDate,
            edition_cleanDate=cleanDate,
            edition_languages=languages,
            edition_placeInferred=placeInferred,
            edition_place=place,
            edition_place2=place2,
            edition_placeClean=placeClean,
            edition_country=country,
            edition_collator_format=format,
            edition_collator_formatNotes=formatNotes,
            edition_imprint=imprint,
            edition_collator_signatures=signatures,
            edition_collator_PpFf=PpFf,
            edition_collator_pages=pages,
            edition_collator_remarks=remarks,
            edition_collator_colophon=colophon,
            edition_collator_illustrated=illustrated,
            edition_collator_typographicMaterial=typographicMaterial,
            edition_collator_sheets=sheets,
            edition_collator_typeNotes=typeNotes,
            edition_collator_stcNotes=stcNotes,
            edition_collator_fb=fb,
            edition_collator_nb=nb,
            edition_collator_ib=ib,
            edition_collator_correct=correct,
            edition_collator_locFingerprints=locFingerprints,
            edition_collator_stcnFingerprints=stcnFingerprints,
            edition_collator_tpt=tpt,
            edition_notes=notes,
            edition_printer=printer,
            edition_urlImage=urlImage,
            edition_class0=class0,
            edition_class1=class1,
            edition_internal=internal,
            edition_class2=class2,
            edition_digital=digital,
            edition_fulltext=fulltext,
            edition_tpimage=tpimage,
            edition_privelege=privelege,
            edition_dedication=dedication,
            edition_reference=reference,
            edition_location=location,
            edition_citation=citation,
            
        )
        print(edition)
        try:
            # On l'ajoute au transport vers la base de données
            db.session.add(edition)
            # On envoie le paquet
            db.session.commit()

            # On renvoie le commentaire
            return True, edition
        except Exception as erreur:
            return False, [str(erreur)]




class Authorite(db.Model):
    authorite_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    authorite_forme_retenue = db.Column(db.Text, nullable=False)
    authorite_forme_rejetee = db.Column(db.Text)
    edit_author = db.relationship("Edit_author", back_populates="authorite")

    def creer_authorite(forme_retenue, forme_rejetee):

        # On crée un commentaire
        authorites = Authorite(
            authorite_forme_retenue=forme_retenue,
            authorite_forme_rejetee=forme_rejetee,

        )
        print(authorites)
        try:
            # On l'ajoute au transport vers la base de données
            db.session.add(authorites)
            # On envoie le paquet
            db.session.commit()

            # On renvoie le commentaire
            return True, authorites
        except Exception as erreur:
            return False, [str(erreur)]

class Bibliothecae(db.Model):
    bibliothecae_id = db.Column(db.Text, unique=True, nullable=False, primary_key=True, autoincrement=True)
    bibliothecae_library = db.Column(db.Text)
    bibliothecae_web = db.Column(db.Text)
    bibliothecae_weighting = db.Column(db.Text)
    exemplaire = db.relationship("Exemplaire", back_populates="bibliothecae")

    def ajout_bibliotheque(library, web, weighting):

        # On crée un commentaire
        bibliotheques = Bibliothecae(
            bibliothecae_library=library,
            bibliothecae_web=web,
            bibliothecae_weighting=weighting,

        )
        print(bibliotheques)
        try:
            # On l'ajoute au transport vers la base de données
            db.session.add(bibliotheques)
            # On envoie le paquet
            db.session.commit()

            # On renvoie le commentaire
            return True, bibliotheques
        except Exception as erreur:
            return False, [str(erreur)]

class Exemplaire(db.Model):
    exemplaire_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    exemplaire_library_code_text = db.Column(db.Text)
    exemplaire_pressmark = db.Column(db.Text)
    exemplaire_size = db.Column(db.Text)
    exemplaire_exemp_status = db.Column(db.Text)
    exemplaire_digitalURL = db.Column(db.Text)
    exemplaire_notes = db.Column(db.Text)
    exemplaire_provenance = db.Column(db.Text)
    exemplaire_locFingerprint = db.Column(db.Text)
    exemplaire_stcnFingerprint = db.Column(db.Text)
    exemplaire_statusLevel = db.Column(db.Text)
    exemplaire_in = db.Column(db.Text)
    exemplaire_collator_PpFf = db.Column(db.Text)
    exemplaire_dateSeen = db.Column(db.Text)
    exemplaire_collator_dimensions = db.Column(db.Text)
    exemplaire_collator_digitaLink= db.Column(db.Text)
    exemplaire_reliure_material = db.Column(db.Text)
    exemplaire_reliure_description_det  = db.Column(db.Text)
    exemplaire_reliure_attribution = db.Column(db.Text)
    exemplaire_reliure_century  = db.Column(db.Text)
    exemplaire_reliure_place= db.Column(db.Text)
    exemplaire_edition_id = db.Column(db.Integer, db.ForeignKey('edition.edition_id'))
    exemplaire_bibliothecae_id = db.Column(db.Text, db.ForeignKey('bibliothecae.bibliothecae_id'))
    edition = db.relationship("Edition", back_populates="exemplaire")
    bibliothecae = db.relationship("Bibliothecae", back_populates="exemplaire")
    provenance = db.relationship("Provenance", back_populates="exemplaire")

    


    def ajout_exemplaire(library_code_text, pressmark, size, exemp_status, digitalURL, PpFf, notes, provenance, locFingerprint, stcnFingerprint, statusLevel, In, dateSeen, dimensions, digitalLink, material, description_det, attribution, century, place, edition_id, bibliothecae_id):

        # On crée un commentaire
        exemplars = Exemplaire(
            exemplaire_library_code_text=library_code_text,
            exemplaire_pressmark=pressmark,
            exemplaire_size=size,
            exemplaire_exemp_status=exemp_status,
            exemplaire_digitalURL=digitalURL,
            exemplaire_collator_PpFf=PpFf,
            exemplaire_notes=notes,
            exemplaire_provenance=provenance,
            exemplaire_locFingerprint=locFingerprint,
            exemplaire_stcnFingerprint=stcnFingerprint,
            exemplaire_statusLevel=statusLevel,
            exemplaire_in=In,
            exemplaire_dateSeen=dateSeen,
            exemplaire_collator_dimensions=dimensions,
            exemplaire_collator_digitaLink=digitalLink,
            exemplaire_reliure_material=material,
            exemplaire_reliure_description_det=description_det,
            exemplaire_reliure_attribution=attribution,
            exemplaire_reliure_century=century,
            exemplaire_reliure_place=place,
            exemplaire_edition_id=edition_id,
            exemplaire_bibliothecae_id=bibliothecae_id
        )
        print(exemplars)
        try:
            # On l'ajoute au transport vers la base de données

            db.session.add(exemplars)
            # On envoie le paquet
            db.session.commit()


            # On renvoie le commentaire
            return True, exemplars
        except Exception as erreur:
            return False, [str(erreur)]

class Edit_author(db.Model):
    __tablename__ = "edit_auteur"
    edit_author_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    edit_author_edition_id = db.Column(db.Integer, db.ForeignKey('edition.edition_id'))
    edit_author_autorite_id = db.Column(db.Integer, db.ForeignKey('authorite.authorite_id'))
    edition = db.relationship("Edition", back_populates="edit_author")
    authorite = db.relationship("Authorite", back_populates="edit_author")

    @staticmethod
    def aut_lien(authored):
        lien = Edit_author(
              edit_author_autorite_id=authored
        )
        try:
            db.session.add(lien)
            db.session.commit()
            return True
        except Exception as erreur:
            return False, [str(erreur)]

    @staticmethod
    def edit_lien(authored):
        lien = Edit_author(
              edit_author_edition_id=authored
        )
        try:
            db.session.add(lien)
            db.session.commit
            return True
        except Exception as erreur:
            return False, [str(erreur)]
    


class Reference(db.Model):
    reference_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    reference_refSequential = db.Column(db.Integer)
    reference_references = db.Column(db.Text)
    reference_volume = db.Column(db.Text)
    reference_page = db.Column(db.Text)
    reference_recordNumber = db.Column(db.Text)
    reference_note = db.Column(db.Text)
    reference_referencesSequential = db.Column(db.Text)
    reference_bibliographie_id = db.Column(db.Integer, db.ForeignKey('bibliographie.bibliographie_id'))
    reference_edition_id = db.Column(db.Integer, db.ForeignKey('edition.edition_id'))
    edition = db.relationship("Edition", back_populates="reference")
    bibliographie = db.relationship("Bibliographie", back_populates="reference")

    def ajout_reference(refSequential, references, volume, page, recordNumber, note, referencesSequential):
        refs=Reference(
            reference_refSequential=refSequential,
            reference_references=references,
            reference_volume=volume,
            reference_page=page,
            reference_recordNumber=recordNumber,
            reference_note=note,
            reference_referencesSequential=referencesSequential,

        )
        print(refs)
        try:
             db.session.add(refs)
             db.session.commit()
        except Exception as erreur:
            return False, [str(erreur)]


class Bibliographie(db.Model):
    bibliographie_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    bibliographie_code = db.Column(db.Text)
    bibliographie_author = db.Column(db.Text)
    bibliographie_bibliReference = db.Column(db.Text)
    bibliographie_title = db.Column(db.Text)
    bibliographie_imprint = db.Column(db.Text)
    bibliographie_urlLink = db.Column(db.Text)
    reference = db.relationship("Reference", back_populates="bibliographie")

    def ajout_bibliographie(code, author, bibliReference, title, imprint, urlLink):
        bibliographia=Bibliographie(
            bibliographie_code=code,
            bibliographie_author=author,
            bibliographie_bibliReference=bibliReference,
            bibliographie_title=title,
            bibliographie_imprint=imprint,
            bibliographie_urlLink=urlLink,
        )

        print(bibliographia)
        try:
            db.session.add(bibliographia)
            db.session.commit()
        except Exception as erreur:
            return False, [str(erreur)]


class Citation(db.Model):
    citation_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    citation_dbname = db.Column(db.Text)
    citation_dbnumber = db.Column(db.Integer)
    citation_numberOfDups = db.Column(db.Integer)
    citation_url = db.Column(db.Text)
    citation_edition_id = db.Column(db.Integer, db.ForeignKey('edition.edition_id'))
    edition = db.relationship("Edition", back_populates="citation")

    def ajout_citation(dbname, dbnumber, numberOfDumps, url):
        citations=Citation(
            citation_dbname=dbname,
            citation_dbnumber=dbnumber,
            citation_numberOfDumps=numberOfDumps,
            citation_url=url,
        )
        print(citations)
        try:
            db.session.add(citations)
            db.session.commit()
        except Exception as erreur:
            return False, [str(erreur)]


class Digital(db.Model):
    digital_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    digital_url = db.Column(db.Text)
    digital_provider = db.Column(db.Text, nullable=False)
    digital_edition_id = db.Column(db.Integer, db.ForeignKey('edition.edition_id'))
    digital_digitization_id = db.Column(db.Integer, db.ForeignKey('digitization.digitization_id'))
    edition = db.relationship("Edition", back_populates="digital")
    digitization = db.relationship("Digitization", back_populates="digital")

    def ajout_digital(url, provider):
        digitals=Digital(
           digital_url=url,
           digital_provider=provider
        )
        print(digitals)
        try:
            db.session.add(digitals)
            db.session.commit()
        except Exception as erreur:
            return False, [str(erreur)]



class Digitization(db.Model):
    digitization_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    digitization_provider = db.Column(db.Text)
    digitization_fullName = db.Column(db.Text)
    digitization_nationality = db.Column(db.Text)
    digitization_status = db.Column(db.Text)
    digitization_web = db.Column(db.Text)
    digitization_address = db.Column(db.Text)
    digitization_town = db.Column(db.Text)
    digitization_country = db.Column(db.Text)
    digitization_postcode = db.Column(db.Text)
    digitization_telephone = db.Column(db.Text)
    digitization_fax = db.Column(db.Text)
    digitization_email = db.Column(db.Text)
    digitization_notes = db.Column(db.Text)
    digital = db.relationship("Digital", back_populates="digitization")

    def ajout_digitazation(provider, fullName, nationality, status, web, address, town, country, postcode, telephone, fax, email, notes):
        digitizations=Digitization(
           digitization_provider = provider,
           digitization_fullName = fullName,
           digitization_nationality = nationality,
           digitization_status = status,
           digitization_web = web,
           digitization_address = address,
           digitization_town = town,
           digitization_country = country,
           digitization_postcode = postcode,
           digitization_telephone = telephone,
           digitization_fax = fax,
           digitization_email = email,
           digitization_notes = notes
        )
        print(digitizations)
        try:
            db.session.add(digitizations)
            db.session.commit()
        except Exception as erreur:
            return False, [str(erreur)]


class Provenance(db.Model):
    provenance_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    provenance_exLibris = db.Column(db.Text)
    provenance_exDono = db.Column(db.Text)
    provenance_envoi = db.Column(db.Text)
    provenance_notesManuscrites = db.Column(db.Text)
    provenance_armesPeintes = db.Column(db.Text)
    provenance_restitue = db.Column(db.Text)
    provenance_mentionEntree = db.Column(db.Text)
    provenance_estampillesCachets = db.Column(db.Text)
    provenance_exemplaire_id = db.Column(db.Integer, db.ForeignKey('exemplaire.exemplaire_id'))
    exemplaire = db.relationship("Exemplaire", back_populates="provenance")

    def ajout_provenance(exlibris, exdono, envoi, notesManuscrites, armesPeintes, restitue, mentionEntree, estampillesCachets):
         provenances=Provenance(
             provenance_exLibris = exlibris,
             provenance_exDono = exdono,
             provenance_envoi = envoi,
             provenance_notesManuscrites = notesManuscrites,
             provenance_armesPeintes = armesPeintes,
             provenance_restitue = restitue,
             provenance_mentionEntree = mentionEntree,
             provenance_estampillesCachets = estampillesCachets
         )
         print(provenances)
         try:
             db.session.add(provenances)
             db.session.commit()
         except Exception as erreur:
             return False, [str(erreur)]



