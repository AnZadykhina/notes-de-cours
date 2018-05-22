from ..app import db



# On crée notre modèle
class Edition(db.Model):
    edition_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    edition_short_title = db.Column(db.Text)
    edition_title = db.Column(db.Text)
    edition_parallel_title = db.Column(db.Text)
    edition_uniform_title = db.Column(db.Text)
    edition_author_first = db.Column(db.Text, nullable=False)
    edition_author_second = db.Column(db.Text, default="Inconnu")
    edition_publisher = db.Column(db.Text)
    edition_translator = db.Column(db.Text)
    edition_dateInferred = db.Column(db.Text)
    edition_displayDate = db.Column(db.Text)
    edition_cleanDate = db.Column(db.Text)
    edition_languages = db.Column(db.Text)
    edition_placeInferred = db.Column(db.Text)
    edition_place = db.Column(db.Text)
    edition_placeClean = db.Column(db.Text)
    edition_country = db.Column(db.Text)
    edition_imprint = db.Column(db.Text)
    edition_class0 = db.Column(db.Text)
    edition_class1 = db.Column(db.Text)
    edition_class2 = db.Column(db.Text)
    edition_digital = db.Column(db.Text)
    edition_fulltext = db.Column(db.Text)
    edition_tpimage = db.Column(db.Text)
    edition_privelege = db.Column(db.Text)
    edition_dedication = db.Column(db.Text)
    edition_permission = db.Column(db.Text)
    edition_reference = db.Column(db.Text)
    edition_location = db.Column(db.Text)
    edition_citation = db.Column(db.Integer)
    authorite = db.relationship("Authorite", back_populates="edition")
    exemplaire = db.relationship("Exemplaire", back_populates="edition")
    edit_author = db.relationship("Edit_author", back_populates="edition")
    collator = db.relationship("Collator", back_populates="edition")
    reference = db.relationship("Reference", back_populates="edition")

    def creer_edition(short_title, author_first, author_second, publisher, translator, dateInferred, displayDate, cleanDate, languages, placeInferred, place, placeClean, country, imprint, class0, class1, class2, digital, fulltext, tpimage, privelege, dedication, permission,reference, location, citation, collator):
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
            edition_author_first=author_first,
            edition_author_second=author_second,
            edition_publisher=publisher,
            edition_translator=translator,
            edition_dateInferred=dateInferred,
            edition_displayDate=displayDate,
            edition_cleanDate=cleanDate,
            edition_languages=languages,
            edition_placeInferred=placeInferred,
            edition_place=place,
            edition_placeClean=placeClean,
            edition_country=country,
            edition_imprint=imprint,
            edition_class0=class0,
            edition_class1=class1,
            edition_class2=class2,
            edition_digital=digital,
            edition_fulltext=fulltext,
            edition_tpimage=tpimage,
            edition_privelege=privelege,
            edition_dedication=dedication,
            edition_permission=permission,
            edition_reference=reference,
            edition_location=location,
            edition_citation=citation,
            collator = Edition.collator
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
    authorite_edition_id = db.Column(db.Integer, db.ForeignKey('edition.edition_id'))
    edition = db.relationship("Edition", back_populates="authorite")
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
    bibliothecae_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    bibliothecae_library = db.Column(db.Text)
    bibliothecae_web = db.Column(db.Text)
    bibliothecae_weighting = db.Column(db.Text)
    exemplaire = db.relationship("Exemplaire", back_populates="bibliothecae")

    def ajout_authorite(library, web, weighting):

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
    exemplaire_sn = db.Column(db.Integer)
    exemplaire_library_code = db.Column(db.Text, db.ForeignKey('bibliothecae.bibliothecae_id'))
    exemplaire_library_code_text = db.Column(db.Text)
    exemplaire_pressmark = db.Column(db.Text)
    exemplaire_size = db.Column(db.Text)
    exemplaire_exemp_status = db.Column(db.Text)
    exemplaire_digitalURL = db.Column(db.Text)
    exemplaire_provider = db.Column(db.Text)
    exemplaire_notes = db.Column(db.Text)
    exemplaire_locFingerprint = db.Column(db.Text)
    exemplaire_stcnFingerprint = db.Column(db.Text)
    exemplaire_statusLevel = db.Column(db.Text)
    exemplaire_in = db.Column(db.Text)
    exemplaire_dateSeen = db.Column(db.Text)
    exemplaire_edition_id = db.Column(db.Integer, db.ForeignKey('edition.edition_id'))
    edition = db.relationship("Edition", back_populates="exemplaire")
    bibliothecae = db.relationship("Bibliothecae", back_populates="exemplaire")
    reliure = db.relationship("Reliure", back_populates="exemplaire")
    citation = db.relationship("Citation", back_populates="exemplaire")
    digital = db.relationship("Digital", back_populates="exemplaire")
    provenance = db.relationship("Provenance", back_populates="exemplaire")
    autres_bases = db.relationship("Autres_bases", back_populates="exemplaire")


    def ajout_exemplaire(library_code, library_code_text, pressmark, size, exemp_status, digitalURL, provider, notes, locFingerprint, stcnFingerprint, statusLevel, In, dateSeen):

        # On crée un commentaire
        exemplars = Exemplaire(
            exemplaire_library_code=library_code,
            exemplaire_library_code_text=library_code_text,
            exemplaire_pressmark=pressmark,
            exemplaire_size=size,
            exemplaire_exemp_status=exemp_status,
            exemplaire_digitalURL=digitalURL,
            exemplaire_provider=provider,
            exemplaire_notes=notes,
            exemplaire_locFingerprint=locFingerprint,
            exemplaire_stcnFingerprint=stcnFingerprint,
            exemplaire_statusLevel=statusLevel,
            exemplaire_in=In,
            exemplaire_dateSeen=dateSeen,
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

class Reliure(db.Model):
    reliure_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    reliure_material = db.Column(db.Text)
    reliure_provenance = db.Column(db.Text)
    reliure_description_det = db.Column(db.Text)
    reliure_attribution = db.Column(db.Text)
    reliure_century = db.Column(db.Text)
    reliure_place = db.Column(db.Text)
    reliure_exemplaire_id = db.Column(db.Integer, db.ForeignKey('exemplaire.exemplaire_id'))
    exemplaire = db.relationship("Exemplaire", back_populates="reliure")

    def ajout_reliure(material, provenance, description_det, attribution, century, place):

        # On crée un commentaire
        reliures = Reliure(
            reliure_material=material,
            reliure_provenance=provenance,
            reliure_description_det=description_det,
            reliure_attribution=attribution,
            reliure_century=century,
            reliure_place=place,

        )
        print(reliures)
        try:
            # On l'ajoute au transport vers la base de données
            db.session.add(reliures)
            # On envoie le paquet
            db.session.commit()

            # On renvoie le commentaire
            return True, reliures
        except Exception as erreur:
            return False, [str(erreur)]

class Edit_author(db.Model):
    edit_author_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    edit_author_edition_id = db.Column(db.Integer, db.ForeignKey('edition.edition_id'))
    edit_author_autorite_id = db.Column(db.Integer, db.ForeignKey('authorite.authorite_id'))
    edition = db.relationship("Edition", back_populates="edit_author")
    authorite = db.relationship("Authorite", back_populates="edit_author")


class Collator(db.Model):
    collator_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    collator_material = db.Column(db.Text)
    collator_sn = db.Column(db.Integer)
    collator_format = db.Column(db.Integer)
    collator_cleanFormat = db.Column(db.Integer)
    collator_signatures = db.Column(db.Text)
    collator_PpFf = db.Column(db.Text)
    collator_pages = db.Column(db.Integer)
    collator_remarks = db.Column(db.Text)
    collator_colophon = db.Column(db.Text)
    collator_date = db.Column(db.Text)
    collator_displayDate = db.Column(db.Text)
    collator_cleanDate = db.Column(db.Text)
    collator_notes = db.Column(db.Text)
    collator_illustrated = db.Column(db.Text)  # binary
    collator_typographicMaterial = db.Column(db.Text)
    collator_sheets = db.Column(db.Text)
    collator_typeNotes = db.Column(db.Text)
    collator_stcNotes = db.Column(db.Text)
    collator_fb = db.Column(db.Integer)
    collator_nb = db.Column(db.Integer)
    collator_ib = db.Column(db.Integer)
    collator_correct = db.Column(db.Text)  # binary
    collator_locFingerprints = db.Column(db.Text)
    collator_stcnFingerprints = db.Column(db.Text)
    collator_dimensions = db.Column(db.Text)
    collator_digitaLink = db.Column(db.Text)
    collator_tpt = db.Column(db.Text)
    collator_shortTitle = db.Column(db.Text)
    collator_titleNotes = db.Column(db.Text)
    collator_languages = db.Column(db.Text)
    collator_UstcLanguages = db.Column(db.Text)
    collator_place = db.Column(db.Text)
    collator_country = db.Column(db.Text)
    collator_countryCode = db.Column(db.Text)
    collator_imprint = db.Column(db.Text)
    collator_class1 = db.Column(db.Text)
    collator_class2 = db.Column(db.Text)
    collator_edition_id = db.Column(db.Integer, db.ForeignKey('edition.edition_id'))
    edition = db.relationship("Edition", back_populates="collator")


class Reference(db.Model):
    reference_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    reference_sn = db.Column(db.Integer)
    reference_refSequential = db.Column(db.Integer)
    reference_references = db.Column(db.Text)
    reference_volume = db.Column(db.Text)
    reference_page = db.Column(db.Text)
    reference_recordNumber = db.Column(db.Text)
    reference_note = db.Column(db.Text)
    reference_bibliographie_id = db.Column(db.Integer, db.ForeignKey('bibliographie.bibliographie_id'))
    reference_edition_id = db.Column(db.Integer, db.ForeignKey('edition.edition_id'))
    edition = db.relationship("Edition", back_populates="reference")
    bibliographie = db.relationship("Bibliographie", back_populates="reference")


class Bibliographie(db.Model):
    bibliographie_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    bibliographie_code = db.Column(db.Text)
    bibliographie_author = db.Column(db.Text)
    bibliographie_title = db.Column(db.Text)
    bibliographie_imprint = db.Column(db.Text)
    bibliographie_urlLink = db.Column(db.Text)
    reference = db.relationship("Reference", back_populates="bibliographie")


class Citation(db.Model):
    citation_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    citation_sn = db.Column(db.Integer)
    citation_dbname = db.Column(db.Text)
    citation_dbnumber = db.Column(db.Integer)
    citation_numberOfDumps = db.Column(db.Integer)
    citation_url = db.Column(db.Text)
    citation_exemplaire_id = db.Column(db.Integer, db.ForeignKey('exemplaire.exemplaire_id'))
    exemplaire = db.relationship("Exemplaire", back_populates="citation")


class Digital(db.Model):
    digital_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    digital_sn = db.Column(db.Integer)
    digital_url = db.Column(db.Text)
    digital_provider = db.Column(db.Text, nullable=False)
    digital_exemplaire_id = db.Column(db.Integer, db.ForeignKey('exemplaire.exemplaire_id'))
    exemplaire = db.relationship("Exemplaire", back_populates="digital")
    digitization = db.relationship("Digitization", back_populates="digital")


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
    digitization_digital_id = db.Column(db.Integer, db.ForeignKey('digital.digital_id'))
    digital = db.relationship("Digital", back_populates="digitization")


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


class Autres_bases(db.Model):
    autres_bases_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    autres_bases_nom = db.Column(db.Text)
    autres_bases_numero = db.Column(db.Text)
    autres_bases_lien = db.Column(db.Text)
    autres_bases_exemplaire_id = db.Column(db.Integer, db.ForeignKey('exemplaire.exemplaire_id'))
    exemplaire = db.relationship("Exemplaire", back_populates="autres_bases")


